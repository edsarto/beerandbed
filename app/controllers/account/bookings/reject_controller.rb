module Account
  module Bookings
    class RejectController < Account::Base
      def create
        @booking = Booking.find(params[:booking_id])
        if @booking.bed.owner == current_user || @booking.client == current_user
          @booking.status = :canceled
          @booking.save
          BookingMailer.cancel_booking(@booking).deliver_later
          BookingMailer.cancel_booking_from_client(@booking).deliver_later

          redirect_to account_dashboard_path
        else
          flash[:alert] = "Sorry, you are not allowed to make this action"
          redirect_to account_dashboard_path
        end
      end
    end
  end
end
