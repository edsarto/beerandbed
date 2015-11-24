class RenameTerritoriesToBeds < ActiveRecord::Migration
  def self.up
    rename_table :territories, :beds
  end

  def self.down
    rename_table :beds, :territories
  end
end
