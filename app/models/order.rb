class Order < ApplicationRecord
  validates_presence_of :status
  has_many :order_items
  has_many :items, through: :order_items
  belongs_to :user

  def grand_total
    order_items.sum('price * quantity')
  end

  enum status: ["pending", "packaged", "shipped", "canceled"]

end
