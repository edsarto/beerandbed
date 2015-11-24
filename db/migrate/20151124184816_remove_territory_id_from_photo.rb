class RemoveTerritoryIdFromPhoto < ActiveRecord::Migration
  def change
    remove_column :photos, :territory_id, :integer
  end
end
