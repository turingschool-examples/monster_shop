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
               .where('users.enabled = true')
               .order('city_state')
               .distinct
               .pluck("CONCAT_WS(', ', users.city, users.state) AS city_state")
  end

  def pending_orders
    Order.joins(:items)
         .joins('JOIN users ON orders.user_id = users.id')
         .where('users.enabled')
         .select('orders.*, sum(order_items.price * order_items.quantity) AS g_total, sum(order_items.quantity) AS n_items')
         .group('orders.id')
         .where(orders: {status: 'pending'})
         .where(items: {merchant_id: self.id})
  end

  def self.all_names
    pluck(:name)
  end
end
