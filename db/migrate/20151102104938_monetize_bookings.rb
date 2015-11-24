class MonetizeBookings < ActiveRecord::Migration
  def change
    add_monetize :bookings, :total_price, currency: { present: false }
  end
end
