class MicropostsController < ApplicationController
  before_action :logged_in_user, only: %i(create destroy)
  before_action :correct_user, only: :destroy

  def create
    @micropost = current_user.microposts.build micropost_params
    @micropost.image.attach micropost_params[:image]
    @feed_items = Micropost.feed(current_user.id).page(params[:page])
                              .per Settings.micropost.per_of_page
    flash.now[:danger] = t "microposts.controllers.created_failed"
    render "static_pages/home" and return unless @micropost.save

    flash[:success] = t "microposts.controllers.created_succeed"
    redirect_to root_url
  end

  def destroy
    if @micropost.destroy
      flash[:success] = t "microposts.controllers.succeed_deletting"
      redirect_to request.referer || root_url
    else
      flash[:danger] = t "microposts.controllers.failed_deletting"
      redirect_to root_url
    end
  end

  private

  def micropost_params
    params.require(:micropost).permit :content, :image
  end

  def correct_user
    @micropost = current_user.microposts.find_by id: params[:id]
    return if @micropost

    flash[:danger] = t "microposts.controllers.not_find_micropost"
    redirect_to root_url
  end
end
