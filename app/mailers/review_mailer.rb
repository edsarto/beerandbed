class ReviewMailer < ApplicationMailer

  def create_review(review)
    @review = review

    mail(
      to:       @review.booking.bed.owner.email,
      subject:  "#{@review.booking.client.first_name} posted a review on your bed #{@review.booking.bed.name}!"
    )
  end
end
