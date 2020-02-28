class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.string "title"
      t.string "description"
      t.integer "rating"
      t.bigint "item_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["item_id"], name: "index_reviews_on_item_id"
    end
  end
end
