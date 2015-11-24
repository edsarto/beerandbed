module Bookings
  class PaymentController < Account::Base

    before_action :set_booking, only: [:new, :create]

    def show
      @booking = current_user.bookings.where(checkout_status: :paid).find(params[:booking_id])
      @payment = @booking.payments
    end

    def new
      # Besoin d'un Base controller qui authenticate user ?
      @user = current_user
      @user.create_or_update_wallet
      @user.save

      params = {
        UserId: current_user.mangopay_user_id,
        Currency: "EUR",
        CardType: "CB_VISA_MASTERCARD"
      }

      @card_registration = MangoPay::CardRegistration.create(params)

      @credit_cards = current_user.credit_cards
      @payment = @booking.payments.build
    end

    def create
      @payment = @booking.payments.build(payment_params)
      @booking.checkout_status = :payment
      @booking.save
      @payment.amount = @booking.total_price
      @payment.charge
      case @payment.state
      when 'accepted'
        flash[:notice] = "Merci ! Votre paiement a bien été pris en compte"
        @booking.checkout_status = :paid
        @booking.status = :pending
        @booking.save
        BookingMailer.send_request(@booking).deliver_later
        redirect_to booking_payment_path(@booking)
      when 'refused'
        flash[:error] = "Désolé, votre paiement a été refusé... merci de bien vouloir réessayer"
        render :new
      when 'error'
        flash[:error] = "Désolé, le service de paiement est momentanément indisponible..."
        render :new
      else
        flash[:error] = "42"
        render :new
      end
    end

    private

    def set_booking
      @booking = current_user.bookings.where(checkout_status: :address).find(params[:booking_id])
    end

    def payment_params
      params.require(:payment).permit(:credit_card_id, :booking_id, :amount)
    end
  end
end

