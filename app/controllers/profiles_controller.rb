class ProfilesController < ApplicationController
  include Pundit

  def show
    @user = User.find(params[:id])
  end
end
