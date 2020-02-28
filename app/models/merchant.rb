class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :order_items, through: :items
  has_many :users

  validates_presence_of :name,
                        :address,
                        :city,
                        :state,
                        :zip

  validates :enabled, inclusion: { in: [true, false] }

  def item_count
    items.count
  end

  def average_item_price
    items.average(:price)
  end

  def distinct_cities
    order_items.joins('JOIN orders ON order_items.order_id = orders.id')
               .joins('JOIN users ON orders.user_id = users.id')
               .order('city_state')
               .distinct
               .pluck("CONCAT_WS(', ', users.city, users.state) AS city_state")
  end

  def disable
  	update_attribute(:enabled, false)
  	items.each do |item|
    	item.update(active: false)
  	end
	end

	def enable
	  update_attribute(:enabled, true)
	  items.each do |item|
    	item.update(active: true)
	  end
	end

  def pending_orders
    order_items.joins(:order).where("orders.status = 0")
  end

	# def merchant_orders
	#   items.joins(:orders)
	# end

  # def items_in_order
  #     items.joins(:orders)
  # end
end
