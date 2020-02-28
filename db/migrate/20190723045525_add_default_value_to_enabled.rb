class AddDefaultValueToEnabled < ActiveRecord::Migration[5.1]
  def change
    change_column_default :merchants, :enabled, true
  end
end
