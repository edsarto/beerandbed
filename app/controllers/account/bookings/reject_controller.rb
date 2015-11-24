module Account
  module Bookings
    class RejectController < Account::Base
      def create
        @booking = Booking.find(params[:booking_id])
        if @booking.territory.owner == current_user || @booking.client == current_user
          @booking.status = :canceled
          @booking.save
          BookingMailer.cancel_booking(@booking).deliver_later
          BookingMailer.cancel_booking_from_client(@booking).deliver_later

          redirect_to account_dashboard_path
        else
          flash[:alert] = "Désolé, vous n'êtes pas autorisé à faire cette action"
          redirect_to account_dashboard_path
        end
      end
    end
  end
end
