class CreditLine < ActiveRecord::Base
#   t.String :name
#   t.Float :annual_interest
  belongs_to :account
end
