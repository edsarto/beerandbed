class RenameDateAttributesToBookings < ActiveRecord::Migration
  def change
    rename_column :bookings, :start_date, :starting_on
    rename_column :bookings, :end_date, :ending_on
  end
end
