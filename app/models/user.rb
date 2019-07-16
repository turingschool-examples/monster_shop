class User < ApplicationRecord
  has_secure_password

  validates :email, uniqueness: true, presence: true
  validates :state, presence: true, length: { is: 2 }
  validates :zip, presence: true, numericality: true, length: { is: 5 }
  validates_presence_of :name, :address, :city

  enum role: ["regular_user", "merchant", "admin"]
end
