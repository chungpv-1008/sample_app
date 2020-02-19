class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user&.authenticate(params[:session][:password])
      log_in user
      flash[:success] = t "sessions.welcome_back"
      redirect_to user
    else
      flash.now[:danger] = t "sessions.login_failed"
      render :new
    end
  end

  def destroy
    log_out
    flash[:success] = t "sessions.log_out_success"
    redirect_to root_url
  end
end
