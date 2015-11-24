module Account
  class BedsController < Account::Base
    include Pundit

    after_action :verify_authorized, except: [:index, :show]

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    def index
      @beds = current_user.beds.all
    end

    def new
      @bed = Bed.new
      authorize @bed
    end

    def create
      @bed = current_user.beds.build(bed_params)
      authorize @bed

      if @bed.save
        flash[:notice] = "Merci d'avoir créé un nouveau lit!"
        BedMailer.creation_confirmation(@bed).deliver_later
        @bed.owner.create_or_update_wallet
        redirect_to account_dashboard_path
      else
        flash[:alert] = "Désolé, nous n'avons pas pu créer votre nouveau lit. Veuillez réessayer!"
        render :new
      end
    end

    def edit
      @bed = Bed.find(params[:id])
      authorize @bed
    end

    def update
      @bed = current_user.beds.find(params[:id])
      authorize @bed

      @bed.owner.create_or_update_wallet
      @bed.update(bed_params)
      redirect_to bed_path(@bed)
    end

    private

    def user_not_authorized
      flash[:alert] = "Désolé, vous n'êtes pas autorisé à faire cette action"
      redirect_to(root_path)
    end

    def bed_params
      params.require(:bed).permit(:name, :description, :category, :price, :city, :zipcode, :street, :max_number_of_guests, :policy, :picture, :direction)
    end
  end
end
