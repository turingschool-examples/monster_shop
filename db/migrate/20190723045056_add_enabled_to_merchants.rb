class AddEnabledToMerchants < ActiveRecord::Migration[5.1]
  def change
    add_column :merchants, :enabled, :boolean
  end
end
