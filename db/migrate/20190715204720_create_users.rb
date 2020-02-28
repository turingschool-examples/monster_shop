class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :user_name
      t.string :password
      t.integer :role, default: 0
      t.string :address
      t.string :city
      t.string :state
      t.string :zip

      t.timestamps
    end
  end
end
