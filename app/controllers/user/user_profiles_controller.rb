class User::UserProfilesController < User::ApplicationController
  protect_from_forgery :except => [:create, :update]

  def new
    @user_profile = UserProfile.new
  end

  def create
    @user_profile = current_user.build_user_profile(user_profile_params.except(:avatar))
    @user_profile.base64upload(user_profile_params[:avatar])
    respond_to do |format|
      if @user_profile.save
        format.html
        format.json { render json: @user_profile, status: :created}
      else
        format.html
        format.json { render json: @user_profile.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @user_profile = current_user.user_profile
  end

  def update
    if current_user.user_profile.update(user_profile_params)
      redirect_to user_trades_path
    else
      render "edit"
    end
  end

  private

  def user_profile_params
    params.require(:user_profile).permit(:nickname, :avatar)
  end
end