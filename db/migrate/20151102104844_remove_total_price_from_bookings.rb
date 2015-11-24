class RemoveTotalPriceFromBookings < ActiveRecord::Migration
  def change
    remove_column :bookings, :total_price, :integer
  end
end
