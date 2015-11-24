class AddOwnerArchiveToBooking < ActiveRecord::Migration
  def change
    add_column :bookings, :owner_archive, :boolean, default: false
  end
end
