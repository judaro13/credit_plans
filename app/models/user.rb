class User < ActiveRecord::Base
#   t.string :email,              null: false, default: ""
#   t.string :encrypted_password, null: false, default: ""
#   t.string :name
#   t.string :last_name
  #   t.string :company_name
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :account
  
  after_create :create_account
  
  def create_account
    account = Account.create(name: company_name, path: "/account/#{company_name}")
    self.account = account
    self.save
  end
  
end
