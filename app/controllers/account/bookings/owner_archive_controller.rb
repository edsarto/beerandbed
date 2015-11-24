module Account
  module Bookings
    class OwnerArchiveController < Account::Base
      def create
        @booking = Booking.find(params[:booking_id])

        if @booking.bed.owner == current_user
          @booking.owner_archive = true
          @booking.save

          redirect_to account_dashboard_path
        else
          redirect_to account_dashboard_path
        end
      end
    end
  end
end
