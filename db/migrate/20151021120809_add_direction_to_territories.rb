class AddDirectionToTerritories < ActiveRecord::Migration
  def change
    add_column :territories, :direction, :text
  end
end
