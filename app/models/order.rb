class Order < ApplicationRecord
  has_many :order_items
  has_many :items, through: :order_items
  belongs_to :user

  def grand_total
    order_items.sum('price * quantity')
  end

  def subtotal(item_id)
    item = order_items.select(:price, :quantity).where(item_id: item_id).first
    item.price * item.quantity
  end

  def count_of(item_id)
    order_items.select(:quantity).where(item_id: item_id).first.quantity
  end

  def num_items
    order_items.sum(:quantity)
  end

  enum status: ["pending", "packaged", "shipped", "canceled"]

end
