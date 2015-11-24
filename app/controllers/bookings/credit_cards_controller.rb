module Bookings
  class CreditCardsController < ApplicationController
    def index
      @credit_cards = current_user.credit_cards
    end

    def new
      @user = current_user
      @user.create_or_update_wallet
      @user.save

      params = {
        UserId: current_user.mangopay_user_id,
        Currency: "EUR",
        CardType: "CB_VISA_MASTERCARD"
      }

      @card_registration = MangoPay::CardRegistration.create(params)
    end

    def create
      @booking = current_user.bookings.where(checkout_status: [:cart, :address]).find(params[:booking_id])
      @credit_card = current_user.credit_cards.build(mangopay_card_id: params[:mangopay_card_id])
      @credit_card.name = params[:credit_card_name]

      if @credit_card.save
        flash[:notice] = "Vous pouvez maintenant utiliser cette carte pour effectuer le paiement"
        redirect_to new_booking_payment_path(@booking)
      else
        redirect_to new_booking_credit_card_path(@booking)
      end
    end
  end
end
