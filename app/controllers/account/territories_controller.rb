module Account
  class TerritoriesController < Account::Base
    include Pundit

    after_action :verify_authorized, except: [:index, :show]

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    def index
      @territories = current_user.territories.all
    end

    def new
      @territory = Territory.new
      authorize @territory
    end

    def create
      @territory = current_user.territories.build(territory_params)
      authorize @territory

      if @territory.save
        flash[:notice] = "Merci d'avoir créé un nouveau territoire!"
        TerritoryMailer.creation_confirmation(@territory).deliver_later
        @territory.owner.create_or_update_wallet
        redirect_to account_dashboard_path
      else
        flash[:alert] = "Désolé, nous n'avons pas pu créer votre nouveau territoire. Veuillez réessayer!"
        render :new
      end
    end

    def edit
      @territory = Territory.find(params[:id])
      authorize @territory
    end

    def update
      @territory = current_user.territories.find(params[:id])
      authorize @territory

      @territory.owner.create_or_update_wallet
      @territory.update(territory_params)
      redirect_to territory_path(@territory)
    end

    private

    def user_not_authorized
      flash[:alert] = "Désolé, vous n'êtes pas autorisé à faire cette action"
      redirect_to(root_path)
    end

    def territory_params
      params.require(:territory).permit(:name, :description, :category, :price, :city, :zipcode, :street, :max_number_of_guests, :policy, :picture, :direction)
    end
  end
end
