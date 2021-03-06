class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user&.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == "1" ? remember(user) : forget(user)
        flash[:success] = t "sessions.controllers.welcome_back"
        redirect_back_or user
      else
        flash[:warning] = t "sessions.controllers.account_not_activated"
        redirect_to root_url
      end
    else
      flash.now[:danger] = t "sessions.controllers.login_failed"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    flash[:success] = t "sessions.controllers.log_out_success"
    redirect_to root_url
  end
end
