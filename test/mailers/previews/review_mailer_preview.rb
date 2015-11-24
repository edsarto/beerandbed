class ReviewMailerPreview < ActionMailer::Preview

  def create_review
    review = Review.first
    ReviewMailer.create_review(review)
  end
end
