class BookingMailer < ApplicationMailer

  def send_request(booking)
    @booking = booking

    mail(
      to: @booking.bed.owner.email,
      subject: 'Nouvelle demande de réservation !'
      )
  end

  def confirmation(booking)
    @booking = booking

    mail(
      to: @booking.client.email,
      subject: "Réservation confirmée !"
      )
  end

  def cancel_booking(booking)
    @booking = booking

    mail(
      to: @booking.client.email,
      subject: "#{@booking.bed.owner.first_name} a annulé votre réservation"
      )
  end

  def cancel_booking_from_client(booking)
    @booking = booking

    mail(
      to: @booking.bed.owner.email,
      subject: "La réservation de #{@booking.client.first_name} est annulée"
      )
  end
end
