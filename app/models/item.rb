class Item < ApplicationRecord
  belongs_to :merchant
  has_many :order_items
  has_many :orders, through: :order_items
  has_many :reviews, dependent: :destroy

  validates_presence_of :name,
                        :description,
                        :price,
                        :inventory

  validates_numericality_of :price, :greater_than => 0
  validates_numericality_of :inventory, :greater_than_or_equal_to => 0

  def sorted_reviews(limit = nil, order = :asc)
    reviews.order(rating: order).limit(limit)
  end

  def average_rating
    reviews.average(:rating)
  end

  def purchased
    OrderItem.all.pluck(:item_id)
  end

  def self.favorite_items
    Item.joins(:order_items).select("items.*, sum(order_items.quantity) as total").group("items.id").order("total desc").order(:name).limit(5)
  end

  def self.least_favorite_items
    least = Item.joins(:order_items).select("items.*, sum(order_items.quantity) as total").group("items.id").order("total asc").order(:name).limit(5)
  end
end
