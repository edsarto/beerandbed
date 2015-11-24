class AddClientArchiveToBooking < ActiveRecord::Migration
  def change
    add_column :bookings, :client_archive, :boolean, default: false
  end
end
