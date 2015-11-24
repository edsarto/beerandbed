class AddNbDaysToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :nb_days, :integer
  end
end
