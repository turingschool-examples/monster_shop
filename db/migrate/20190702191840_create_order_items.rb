class CreateOrderItems < ActiveRecord::Migration[5.1]
  def change
    create_table :order_items do |t|
      t.references :item, foreign_key: true
      t.references :order, foreign_key: true
      t.float :price
      t.integer :quantity
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
