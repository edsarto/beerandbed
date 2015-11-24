module Account
  class BookingsController < Account::Base
    include Pundit

    before_action :find_bed, only: [:new, :create]

    after_action :verify_authorized, except: [:index, :show]

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    def index
      @bookings = current_user.bookings.all
    end

    def show
      @booking = current_user.bookings.where(status: :pending).find(params[:id])
    end

    def new
      @booking = current_user.bookings.build

      authorize @booking
    end

    def create
      @booking = @bed.bookings.build(booking_params)
      authorize @booking

      starting_on = @booking.starting_on
      @booking.ending_on = starting_on + (@booking.nb_days - 1)
      ending_on = @booking.ending_on
      @booking.total_price = @bed.price * (@booking.nb_days)
      @booking.client = current_user
      @booking.status = :checkout
      @booking.checkout_status = :cart
      if Booking.booked?(@bed.id, starting_on, ending_on)
        flash[:alert] = "Désolé, ce lit a déjà été réservé pour ces dates"
        redirect_to new_account_bed_booking_path(@bed)
      elsif Booking.start_date_after_end_date?(starting_on, ending_on)
        flash[:alert] = "Essayez à nouveau! La date de fin doit être postérieure à la date début de la réservation ;)"
        redirect_to new_account_bed_booking_path(@bed)
      elsif @booking.save
        # BookingMailer.send_request(@booking).deliver_later A AJOUTER APRES LE PAIMENT
        redirect_to new_account_booking_address_path(@booking)
      else
        flash[:alert] = "Désolé, nous n'avons pas pu créer votre réservation. Veuillez réessayer !"
        render :new
      end
    end

    private

    def user_not_authorized
      flash[:alert] = "Désolé, vous n'êtes pas autorisé à faire cette action"
      redirect_to(root_path)
    end

    def find_bed
      @bed = Bed.find(params[:bed_id])
    end

    def booking_params
      params.require(:booking).permit(:starting_on, :nb_days, :ending_on, :total_price, :status, :message, :checkout_status)
    end
  end
end

