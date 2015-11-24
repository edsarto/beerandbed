class AddBedToBooking < ActiveRecord::Migration
  def change
    add_reference :bookings, :bed, index: true, foreign_key: true
  end
end
