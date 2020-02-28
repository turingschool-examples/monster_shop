class Order < ApplicationRecord
  validates_presence_of :status

  belongs_to :user

  has_many :order_items
  has_many :items, through: :order_items

  enum status: %w(pending packaged shipped cancelled)

  def grand_total
    order_items.sum('price * quantity')
  end

  def total_quantity
    order_items.sum(:quantity)
  end

  def package_order
    self.update_attributes(status: 1)
  end

  def ship_order
    self.update_attributes(status: 2)
  end

  def cancel_order
    update_attributes(status: :cancelled)
    order_items.each do |oi|
      oi.fulfilled = false
      oi.item.inventory += oi.quantity
      oi.quantity = 0
      oi.save
    end
  end

   def fulfill_order
     order_items.each do |oi|
     oi.update(fulfilled: true)
      oi.item.inventory - oi.quantity
      oi.save
    end
  end

  def items_packaged
    true_or_false = order_items.map do |oi|
      oi.fulfilled == true
    end
    if true_or_false.all? == true
      update_attributes(status: :packaged)
    end
  end

  # def packaged?
  #   binding.pry
  #   Order.joins(order_items)
  # end

  def customer
    self.user
  end
end
