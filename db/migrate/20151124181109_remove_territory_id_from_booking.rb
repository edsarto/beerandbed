class RemoveTerritoryIdFromBooking < ActiveRecord::Migration
  def change
    remove_column :bookings, :territory_id, :integer
  end
end
