class User < ApplicationRecord
  has_secure_password
  validates :email, uniqueness: true, presence: true
  validates_presence_of :password, :name, :address, :city, :state, :zip
end
