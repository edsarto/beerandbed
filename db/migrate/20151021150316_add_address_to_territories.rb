class AddAddressToTerritories < ActiveRecord::Migration
  def change
    add_column :territories, :address, :text
  end
end
