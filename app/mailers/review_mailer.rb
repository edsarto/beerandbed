class ReviewMailer < ApplicationMailer

  def create_review(review)
    @review = review

    mail(
      to:       @review.booking.territory.owner.email,
      subject:  "#{@review.booking.client.first_name} a posté un avis sur votre hutte #{@review.booking.territory.name}!"
    )
  end
end
