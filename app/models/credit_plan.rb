class CreditPlan < ActiveRecord::Base
#   t.String :document
#   t.Date :birth_date
#   t.Float :amount
#   t.String :state
#   t.Integer :risk_level
#   t.integer :months
  has_many :fees, :dependent => :destroy
  belongs_to :account
  belongs_to :credit_line
  
  validates_presence_of :document, :birth_date, :amount, :months
  validates :months, :numericality => {greater_than: 0}
  validates :amount, :numericality => {greater_than: 100000}
end
