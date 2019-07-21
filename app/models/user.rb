class User < ApplicationRecord
  has_secure_password
  has_many :orders
  has_many :order_items, through: :orders

  validates :email, uniqueness: true, presence: true
  validates :state, presence: true, length: { is: 2 }
  validates :zip, presence: true, numericality: true, length: { is: 5 }
  validates_presence_of :name, :address, :city, :role

  enum role: ["user", "employee", "merchant", "admin"]

  validates :merchant_id, presence: true, if: :merchant_type?
  validates :merchant_id, presence: false, unless: :merchant_type?

  def merchant_type?
    role == "employee" || role == "merchant"
  end
end
