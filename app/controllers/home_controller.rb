class HomeController < ApplicationController
  def index
    @beds = Bed.limit(9).order("RANDOM()")
  end
end
