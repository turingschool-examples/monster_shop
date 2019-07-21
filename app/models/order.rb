class Order < ApplicationRecord
  validates_presence_of :status
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

  def cancel_items
    stock = items.joins(:order_items)
                 .select('(items.inventory + order_items.quantity) AS amt, items.*')
                 .where(order_items: {status: 1})
    stock.each do |record|
      record.update(inventory: record.amt)
    end
    order_items.update(status: 0)
  end

  def get_my_items(user)
    items.where(items: {merchant_id: user.merchant_id})
  end

  enum status: ["pending", "packaged", "shipped", "canceled"]
end
