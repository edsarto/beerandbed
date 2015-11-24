class HomeController < ApplicationController
  def index
    @territories = Territory.limit(9).order("RANDOM()")
  end
end
