class User < ActiveRecord::Base
#   t.string :email,              null: false, default: ""
#   t.string :encrypted_password, null: false, default: ""
#   t.string :name
#   t.string :last_name
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :account
end
