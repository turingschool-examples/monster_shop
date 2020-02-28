class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string "name"
      t.string "description"
      t.float "price"
      t.integer "inventory"
      t.string "image"
      t.boolean "active", default: true
      t.bigint "merchant_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["merchant_id"], name: "index_items_on_merchant_id"
    end
  end
end
