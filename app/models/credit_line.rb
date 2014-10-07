class CreditLine < ActiveRecord::Base
#   t.String :name
#   t.Float :annual_interest
  belongs_to :account
  has_many :credit_plans, :dependent => :destroy
  
  validates_presence_of :name, :annual_interest
  validates :annual_interest, :numericality => {greater_than: 0.0}
  
end
