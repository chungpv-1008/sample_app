class UsersController < ApplicationController
  def show
    @user = User.find_by id: params[:id]
    return if @user
    
    flash[:danger] = t "users.signup.not_find_url"
    redirect_to root_path
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t "users.signup.welcome"
      redirect_to @user
    else
      flash.now[:danger] = t "users.signup.failed"
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end
