class OrderItem < ApplicationRecord
  validates_presence_of :price, :quantity, :status
  belongs_to :order
  belongs_to :item

  def subtotal
    quantity * price
  end

  enum status: ["unfulfilled", "fulfilled"]
end
