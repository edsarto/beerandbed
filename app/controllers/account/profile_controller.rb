module Account
  class ProfileController < Account::Base

    def edit
      @user = current_user
      # authorize @user
    end

    def update
      @user = current_user
      # authorize @user

      @user.update(user_params)

      flash[:notice] = "Thank you! Your modifications have been taken into account."
      redirect_to edit_account_profile_path(@user)
    end

    private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :score, :picture, :bio, :insurance)
    end
  end
end
