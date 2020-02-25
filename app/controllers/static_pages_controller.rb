class StaticPagesController < ApplicationController
  def home
    return unless logged_in?

    @micropost = current_user.microposts.build
    @feed_items = Micropost.feed(current_user.id)
                           .order_microposts_desc
                           .page(params[:page])
                           .per Settings.micropost.per_of_page
  end

  def help; end

  def about; end

  def contact; end
end
