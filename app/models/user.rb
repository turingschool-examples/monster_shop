class User < ApplicationRecord
  has_secure_password
  has_many :orders
  has_many :order_items, through: :orders

  validates :email, uniqueness: true, presence: true
  validates :state, presence: true, length: { is: 2 }
  validates :zip, presence: true, numericality: true, length: { is: 5 }
  validates_presence_of :name, :address, :city, :role

  STATES = [ 'AL', 'AK', 'AS', 'AZ', 'AR', 'CA', 'CO', 'CT', 'DE', 'DC', 'FM', 'FL', 'GA', 'GU', 'HI', 'ID', 'IL', 'IN', 'IA', 'KS', 'KY', 'LA', 'ME', 'MH', 'MD', 'MA', 'MI', 'MN', 'MS', 'MO', 'MT', 'NE', 'NV', 'NH', 'NJ', 'NM', 'NY', 'NC', 'ND', 'MP', 'OH', 'OK', 'OR', 'PW', 'PA', 'PR', 'RI', 'SC', 'SD', 'TN', 'TX', 'UT', 'VT', 'VI', 'VA', 'WA', 'WV', 'WI', 'WY' ]

  enum role: ["user", "employee", "merchant", "admin"]

  validates :merchant_id, presence: true, if: :merchant_type?
  validates :merchant_id, presence: false, unless: :merchant_type?

  def merchant_type?
    role == "employee" || role == "merchant"
  end
end
