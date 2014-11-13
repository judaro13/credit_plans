class Fee 
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :month, type: Integer
  field :interest, type: Float
  field :amortization, type: Float
  field :payment, type: Float
  field :balance, type: Float
  
  belongs_to :credit_plan
end
