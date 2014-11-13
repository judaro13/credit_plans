class Account 
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name, type: String
  field :path, type: String
  
  has_many :users
  has_many :credit_lines, :dependent => :destroy
  has_many :credit_plans, :dependent => :destroy
end
