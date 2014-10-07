class Account < ActiveRecord::Base
  has_many :users
  has_many :credit_lines, :dependent => :destroy
  has_many :credit_plans, :dependent => :destroy
end
