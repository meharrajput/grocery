class AddNameColumnToStores < ActiveRecord::Migration
  def change
    add_column :stores, :name, :string
  end
end
