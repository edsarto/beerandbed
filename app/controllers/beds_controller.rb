class BedsController < ApplicationController
  include Pundit

  def index
    page  = params[:page].presence || 1
    @beds = Bed.all

    if params[:category].presence
      @beds = @beds.where(category: params[:category])

      if @beds.empty?
        flash[:notice] = "Aucun lit n'est disponible dans la catégorie sélectionnée !"
        redirect_to beds_path
      end
    end

    if params[:city].presence
      @beds = @beds.near(params[:city], 50)

      if @beds.empty?
        flash[:notice] = "Aucun lit n'est disponible à proximité du lieu demandé, dans la catégorie sélectionnée !"
        redirect_to beds_path
      end
    end

    @beds          = @beds.order(:name).page(page).per(20)
    @geocoded_beds = @beds.where.not(latitude: nil, longitude: nil)
    @search_categories    = Bed.pluck(:category)

    @hash = Gmaps4rails.build_markers(@geocoded_beds) do |bed, marker|
      marker.lat bed.latitude
      marker.lng bed.longitude
      marker.infowindow render_to_string(partial: "/beds/map_box", locals: { bed: bed })
    end
  end

  def show
    @bed = Bed.find(params[:id])

    @marker = Gmaps4rails.build_markers(@bed) do |bed, marker|
      marker.lat bed.latitude
      marker.lng bed.longitude
    end
  end
end
