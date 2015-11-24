class AddConfirmationMessageToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :confirmation_message, :text
  end
end
