module Account
  module Bookings
    class ClientArchiveController < Account::Base
      def create
        @booking = Booking.find(params[:booking_id])

        if @booking.client == current_user
          @booking.client_archive = true
          @booking.save

          redirect_to account_dashboard_path
        else
          redirect_to account_dashboard_path
        end
      end
    end
  end
end
