class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :order_items, through: :items

  validates_presence_of :name,
                        :address,
                        :city,
                        :state,
                        :zip

  def item_count
    items.count
  end

  def average_item_price
    items.average(:price)
  end

  def items_active
    items.update(active: true)
  end

  def items_inactive
    items.update(active: false)
  end

  def distinct_cities
    order_items.joins('JOIN orders ON order_items.order_id = orders.id')
               .joins('JOIN users ON orders.user_id = users.id')
               .order('city_state')
               .distinct
               .pluck("CONCAT_WS(', ', users.city, users.state) AS city_state")
  end

  def pending_orders
    Order.joins(:items)
         .where(status: 0)
         .where(items: {merchant_id: self.id})
         .distinct
  end
end
