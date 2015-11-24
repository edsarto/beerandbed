class BookingMailerPreview < ActionMailer::Preview

  def confirmation
    booking = Booking.first
    BookingMailer.confirmation(booking)
  end

  def send_request
    booking = Booking.first
    BookingMailer.send_request(booking)
  end

  def cancel_booking
    booking = Booking.first
    BookingMailer.cancel_booking(booking)
    BookingMailer.cancel_booking_from_client(booking)
  end
end
