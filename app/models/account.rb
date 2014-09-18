class Account < ActiveRecord::Base
  has_many :users
  has_many :credit_lines
  has_many :credit_plans
end
