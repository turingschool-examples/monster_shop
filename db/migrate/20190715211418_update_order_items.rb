class UpdateOrderItems < ActiveRecord::Migration[5.1]
  def change
    change_column_default :order_items, :fulfilled, false
  end
end
