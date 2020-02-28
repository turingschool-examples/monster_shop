class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "status", default: 0
      t.bigint "user_id"
      t.index ["user_id"], name: "index_orders_on_user_id"
    end
  end
end
