module Account
  module Bookings
    class AcceptController < Account::Base
      before_action :set_booking

      def new
      end

      def create
        @booking.assign_attributes(booking_params)
        @booking.status = :confirmed

        if @booking.save
          BookingMailer.confirmation(@booking).deliver_later
          redirect_to account_dashboard_path
        else
          render :new
        end
      end

      private

      def booking_params
        params.require(:booking).permit(:confirmation_message)
      end

      def set_booking
        @booking = Booking.find(params[:booking_id])

        if @booking.bed.owner != current_user
          flash[:alert] = "Désolé, vous n'êtes pas autorisé à faire cette action"
          redirect_to account_dashboard_path
        end
      end
    end
  end
end
