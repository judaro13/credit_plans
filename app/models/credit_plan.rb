class CreditPlan 
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :document,   type: String
  field :birth_date, type: Date
  field :amount,     type: Float
  field :state,      type: String, default: 'En Proceso'
  field :risk_level, type: Integer
  field :months,     type: Integer
  
  has_many :fees, :dependent => :destroy
  belongs_to :account
  belongs_to :credit_line
  
  validates_presence_of :document, :birth_date, :amount, :months
  validates :months, :numericality => {greater_than: 0}
  validates :amount, :numericality => {greater_than: 100000}
  
  after_create :send_task
  
  def send_task
    Resque.enqueue(EnquenqueModelJob, {object: self.class.to_s,
                                       id: self.id.to_s,
                                       action: 'calculate_fees'})
  end
  
  def calculate_fees
    monto = self.amount
    plazos = self.months
    taza = self.credit_line.annual_interest/100.0
    
    a = (1+taza) ** (plazos*-1)
    cuota_fija = monto/((1-a)/taza)
    
    intereses = monto*taza
    total_amortizado = cuota_fija-intereses
    balance =  monto-total_amortizado
    amortizado = cuota_fija-intereses
    
    unless self.fees.empty?
      self.fees.delete_all
    end
    
    errors = false
    for i in 1..plazos
      fee = Fee.new
      fee.credit_plan_id = self.id
      fee.month = i
      fee.interest = intereses.to_i
      fee.amortization = amortizado.to_i
      fee.payment = cuota_fija.to_i
      fee.balance = balance.to_i
      
      intereses = balance*taza
      amortizado = cuota_fija-intereses
      total_amortizado = total_amortizado+amortizado
      balance =  monto-total_amortizado
      
      unless fee.save   
        puts "fee no grabo: #{fee.inspect}"
        self.fees.delete_all
        errors = true
        return
      end
    end
    
    unless errors
      self.state = 'Procesado'
      self.risk_level = Random.rand(10)
      self.save
    end
  end
end
