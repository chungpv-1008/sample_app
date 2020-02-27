class UsersController < ApplicationController
  before_action :logged_in_user, except: %i(new show create)
  before_action :find_user, except: %i(index new create)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy

  def index
    @users = User.activated_true.page(params[:page])
                 .per Settings.user.per_of_page
  end

  def show
    @microposts = @user.microposts.order_microposts_desc.page(params[:page])
                       .per Settings.micropost.per_of_page
    return if @user.activated?
    
    flash[:info] = t "users.controllers.not_activated_account"
    redirect_to root_url
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t "users.signup.please_check"
      redirect_to root_url
    else
      flash.now[:danger] = t "users.signup.failed"
      render :new
    end
  end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = t "users.controllers.update_succeed"
      redirect_to @user
    else
      flash.now[:danger] = t "users.controllers.update_failed"
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "users.controllers.destroyed_succeed"
      redirect_to users_url
    else
      flash[:danger] = t "users.controllers.destroyed_failed"
      redirect_to users_url
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password,
                                 :password_confirmation
  end

  def correct_user
    return if current_user? @user

    flash[:danger] = t "users.controllers.not_allow"
    redirect_to root_url
  end

  def admin_user
    return if current_user.admin?

    flash[:danger] = t "users.controllers.not_allow"
    redirect_to root_path
  end

  def find_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t "users.controllers.not_find_user"
    redirect_to root_path
  end
end
