class User < ApplicationRecord
  has_secure_password
  has_many :orders
  has_many :order_items, through: :orders

  validates :email, uniqueness: true, presence: true
  validates :state, presence: true, length: { is: 2 }
  validates :zip, presence: true, numericality: true, length: { is: 5 }
  validates_presence_of :name, :address, :city

  enum role: ["user", "merchant", "admin"]

  def self.find_merchants
    self.where(role: :merchant)
  end

  def self.find_users
    self.where(role: :user)
  end
end
