class User < ApplicationRecord
  has_secure_password

  validates :user_name, uniqueness: true, presence: true
  validates_presence_of :password, :on => :create
  validates_confirmation_of :password
  validates_presence_of :name, :address, :city, :state, :zip
  has_many :orders
  belongs_to :merchant, optional: true

  enum role: ["user", "merchant_admin", "admin"]

end
