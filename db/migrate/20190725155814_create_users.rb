class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string "user_name"
      t.string "password_digest"
      t.integer "role", default: 0
      t.string "address"
      t.string "city"
      t.string "state"
      t.string "zip"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.bigint "merchant_id"
      t.string "name"
      t.index ["merchant_id"], name: "index_users_on_merchant_id"
    end
  end
end
