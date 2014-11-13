class CreditPlan 
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :document, type: String
  field :birth_date, type: Date
  field :amount, type: Float
  field :state, type: String
  field :risk_level, type: Integer
  field :months, type: Integer
  
  has_many :fees, :dependent => :destroy
  belongs_to :account
  belongs_to :credit_line
  
  validates_presence_of :document, :birth_date, :amount, :months
  validates :months, :numericality => {greater_than: 0}
  validates :amount, :numericality => {greater_than: 100000}
end
