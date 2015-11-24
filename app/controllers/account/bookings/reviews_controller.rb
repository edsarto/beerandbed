module Account
  module Bookings
    class ReviewsController < Account::Base
      include Pundit

      before_action :find_booking, only: [ :new, :create ]

      after_action :verify_authorized, except: [:index, :show]

      rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

      def new
        @review = @booking.reviews.new
        authorize @review
      end

      def create
        @review = @booking.reviews.build(review_params)
        authorize @review

        if @review.save
          ReviewMailer.create_review(@review).deliver_later
          flash[:notice] = "Merci d'avoir noté #{@booking.territory.name}!"
          redirect_to territory_path(@review.booking.territory)
        else
          render :new
        end
      end

      private

      def user_not_authorized
        flash[:alert] = "Désolé, vous n'êtes pas autorisé à faire cette action"
        redirect_to(root_path)
      end

      def review_params
        params.require(:review).permit(:rating, :comment)
      end
      def find_booking
        @booking = Booking.find(params[:booking_id])
      end
    end
  end
end
