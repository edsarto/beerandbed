class TerritoriesController < ApplicationController
  include Pundit

  def index
    page          = params[:page].presence || 1
    @territories  = Territory.all

    if params[:category].presence
      @territories = @territories.where(category: params[:category])

      if @territories.empty?
        flash[:notice] = "Aucun territoire n'est disponible dans la catégorie sélectionnée !"
        redirect_to territories_path
      end
    end

    if params[:city].presence
      @territories = @territories.near(params[:city], 50)

      if @territories.empty?
        flash[:notice] = "Aucun territoire n'est disponible à proximité du lieu demandé, dans la catégorie sélectionnée !"
        redirect_to territories_path
      end
    end

    @territories          = @territories.order(:name).page(page).per(20)
    @geocoded_territories = @territories.where.not(latitude: nil, longitude: nil)
    @search_categories    = Territory.pluck(:category)

    @hash = Gmaps4rails.build_markers(@geocoded_territories) do |territory, marker|
      marker.lat territory.latitude
      marker.lng territory.longitude
      marker.infowindow render_to_string(partial: "/territories/map_box", locals: { territory: territory })
    end
  end

  def show
    @territory = Territory.find(params[:id])

    @marker = Gmaps4rails.build_markers(@territory) do |territory, marker|
      marker.lat territory.latitude
      marker.lng territory.longitude
    end
  end
end
