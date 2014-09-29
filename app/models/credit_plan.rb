class CreditPlan < ActiveRecord::Base
#   t.String :document
#   t.Date :birth_date
#   t.Float :amount
#   t.String :state
#   t.Integer :risk_level
#   t.integer :months
  has_many :fees
  belongs_to :account
  belongs_to :credit_line
end
