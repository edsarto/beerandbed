class RenamePaymentStateIntoCheckoutStatusFromBookings < ActiveRecord::Migration
  def change
    rename_column :bookings, :payment_state, :checkout_status
  end
end
