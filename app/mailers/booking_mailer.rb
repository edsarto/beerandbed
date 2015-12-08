class BookingMailer < ApplicationMailer

  def send_request(booking)
    @booking = booking

    mail(
      to: @booking.bed.owner.email,
      subject: 'New booking request!'
      )
  end

  def confirmation(booking)
    @booking = booking

    mail(
      to: @booking.client.email,
      subject: "Booking confirmed!"
      )
  end

  def cancel_booking(booking)
    @booking = booking

    mail(
      to: @booking.client.email,
      subject: "#{@booking.bed.owner.first_name} has cancelled your booking"
      )
  end

  def cancel_booking_from_client(booking)
    @booking = booking

    mail(
      to: @booking.bed.owner.email,
      subject: "The booking of #{@booking.client.first_name} is cancelled"
      )
  end
end
