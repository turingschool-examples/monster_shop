class CreateMerchants < ActiveRecord::Migration[5.1]
  def change
    create_table :merchants do |t|
      t.string "name"
      t.string "address"
      t.string "city"
      t.string "state"
      t.integer "zip"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.boolean "enabled", default: true
    end
  end
end
