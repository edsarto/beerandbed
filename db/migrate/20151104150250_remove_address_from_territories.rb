class RemoveAddressFromTerritories < ActiveRecord::Migration
  def change
    remove_column :territories, :address, :string
  end
end
