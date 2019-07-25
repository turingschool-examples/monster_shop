class Item < ApplicationRecord
  belongs_to :merchant
  has_many :order_items
  has_many :orders, through: :order_items
  has_many :reviews, dependent: :destroy

  validates_presence_of :name,
                        :description,
                        :image,
                        :price,
                        :inventory

  def sorted_reviews(limit = nil, order = :asc)
    reviews.order(rating: order).limit(limit)
  end

  def average_rating
    reviews.average(:rating)
  end

  def self.all_active
    where(active: true)
  end

  def self.popular_items(limit, order = 'DESC')
    joins(:order_items)
      .select('items.*, sum(order_items.quantity) AS qty')
      .group('items.id')
      .order("qty #{order}")
      .order("items.name")
      .limit(limit)
  end

  def get_order_item(order_id)
    order_items.where(order_id: order_id).first
  end

  def fulfilled?(order_id)
    order_items.where(order_id: order_id).first.status == 'fulfilled'
  end

  def fulfillable?(qty)
    inventory >= qty
  end
end
