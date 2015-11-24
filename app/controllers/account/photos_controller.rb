module Account
  class PhotosController < Account::Base

    before_action :find_bed, only: [:new, :create, :destroy]

    def new
      @photo = Photo.new
    end

    def create
      @photo = @bed.photos.build(photo_params)

      if @photo.save
        flash[:notice] = "Merci ! Vous pouvez ajouter d'autres photos si vous le souhaitez"
        redirect_to bed_path(@bed)
      else
        flash[:alert] = "Désolé, nous n'avons pas pu ajouter votre photo. Veuillez réessayer !"
        render :new
      end
    end

    def destroy
      @photo = Photo.find(params[:id])
      @photo.destroy
      redirect_to bed_path(@bed)
    end


    private

    def find_bed
      @bed = Bed.find(params[:bed_id])
    end

    def photo_params
      params.require(:photo).permit(:picture)
    end
  end
end
