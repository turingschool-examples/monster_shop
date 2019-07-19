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
    items.update_all(active: true)
  end

  def items_inactive
    items.update_all(active: false)
  end

  def distinct_cities
    order_items.joins('JOIN orders ON order_items.order_id = orders.id')
               .joins('JOIN users ON orders.user_id = users.id')
               .distinct
               .pluck("CONCAT_WS(', ', users.city, users.state) AS city_state")
  end
end
