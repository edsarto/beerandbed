class RemovePriceFromTerritories < ActiveRecord::Migration
  def change
    remove_column :territories, :price, :integer
  end
end
