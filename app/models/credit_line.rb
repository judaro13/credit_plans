class CreditLine 
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name, type: String
  field :annual_interest, type: Float
  
  belongs_to :account
  has_many :credit_plans, :dependent => :destroy
  
  validates_presence_of :name, :annual_interest
  validates :annual_interest, :numericality => {greater_than: 0.0}
  
end
