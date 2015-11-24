module Account
  module Bookings
    class AddressController < Account::Base

      def new
        @booking = Booking.where(client: current_user, checkout_status: :cart).find(params[:booking_id])
        if @booking.address && @booking.address.valid?
          redirect_to edit_account_booking_address_path(@booking, @booking.address)
        else
          @address = @booking.build_address
        end
      end

      def create
        @booking = Booking.where(client: current_user, checkout_status: :cart).find(params[:booking_id])
        @address = @booking.build_address(address_params)
        if @address.save
          @booking.checkout_status = :address
          @booking.save
          redirect_to new_booking_payment_path(@booking)
        else
          render :new
        end
      end

      def edit
        @booking = Booking.where(client: current_user, checkout_status: [:cart, :address]).find(params[:booking_id])
        @address = @booking.address
      end

      def update
        @booking = Booking.where(client: current_user, checkout_status: [:cart, :address]).find(params[:booking_id])
        @address = @booking.build_address(address_params)
        if @address.save
          @booking.checkout_status = :address
          @booking.save
          redirect_to new_booking_payment_path(@booking)
        else
          render :edit
        end
      end

      private

      def address_params
        params.require(:address).permit(:first_name, :last_name, :address, :zipcode, :city)
      end
    end
  end
end
