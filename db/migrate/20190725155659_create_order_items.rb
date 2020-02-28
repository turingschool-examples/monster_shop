class CreateOrderItems < ActiveRecord::Migration[5.1]
  def change
    create_table :order_items do |t|
      t.bigint "item_id"
      t.bigint "order_id"
      t.float "price"
      t.integer "quantity"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.boolean "fulfilled", default: false
      t.index ["item_id"], name: "index_order_items_on_item_id"
      t.index ["order_id"], name: "index_order_items_on_order_id"
    end
  end
end
