class PasswordResetsController < ApplicationController
  before_action :find_user, only: %i(edit update create)
  before_action :valid_user, :check_expiration, only: %i(edit update)

  def new; end

  def edit; end

  def create
    @user.create_reset_digest
    @user.send_password_reset_email
    flash[:info] = t "password_resets.controllers.email_sent_password_reset"
    redirect_to root_url
  end

  def update
    if user_params[:password].blank?
      @user.errors.add :passowrd, t("password_resets.controllers.cant_not_empty")
      render :edit
    elsif @user.update user_params
      log_in @user
      @user.update_attribute :reset_digest, nil
      flash[:success] = t "password_resets.controllers.reset_password_succeed"
      redirect_to @user
    else
      flash.now[:danger] = t "password_resets.controllers.failed_update"
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit :password, :password_confirmation
  end

  def find_user
    email_param = params[:email] ||= params[:password_reset][:email]
    @user = User.find_by email: email_param
    return if @user

    flash.now[:danger] = t "password_resets.controllers.email_not_found"
    render :new
  end

  def valid_user
    return if @user.activated? && @user.authenticated?(:reset, params[:id])

    flash[:danger] = t "password_resets.controllers.not_active_account"
    redirect_to root_url
  end

  def check_expiration
    return unless @user.password_reset_expired?

    flash[:danger] = t "password_resets.controllers.password_reset_expired"
    redirect_to new_password_reset_url
  end
end
