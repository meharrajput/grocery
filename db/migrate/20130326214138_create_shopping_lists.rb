class CreateShoppingLists < ActiveRecord::Migration
  def change
    create_table :shopping_lists do |t|
      t.integer :id
      t.integer :customer_id

      t.timestamps
    end
  end
end