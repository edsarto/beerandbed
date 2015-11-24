class AddPaymentStateToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :payment_state, :string
  end
end
