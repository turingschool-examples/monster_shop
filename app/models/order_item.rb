class OrderItem < ApplicationRecord
  validates_presence_of :price, :quantity
  belongs_to :order
  belongs_to :item

  def subtotal
    quantity * price
  end
end
