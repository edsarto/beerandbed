class AddCoordinatesToTerritories < ActiveRecord::Migration
  def change
    add_column :territories, :latitude, :float
    add_column :territories, :longitude, :float
  end
end
