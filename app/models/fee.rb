class Fee < ActiveRecord::Base
#   t.Integer :month
#   t.Float :interest
#   t.Float :amortization
#   t.Float :payment
#   t.Float :balance
  belongs_to :credit_plan
end
