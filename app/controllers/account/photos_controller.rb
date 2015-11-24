module Account
  class PhotosController < Account::Base

    before_action :find_territory, only: [:new, :create, :destroy]

    def new
      @photo = Photo.new
    end

    def create
      @photo = @territory.photos.build(photo_params)

      if @photo.save
        flash[:notice] = "Merci ! Vous pouvez ajouter d'autres photos si vous le souhaitez"
        redirect_to territory_path(@territory)
      else
        flash[:alert] = "Désolé, nous n'avons pas pu ajouter votre photo. Veuillez réessayer !"
        render :new
      end
    end

    def destroy
      @photo = Photo.find(params[:id])
      @photo.destroy
      redirect_to territory_path(@territory)
    end


    private

    def find_territory
      @territory = Territory.find(params[:territory_id])
    end

    def photo_params
      params.require(:photo).permit(:picture)
    end
  end
end
