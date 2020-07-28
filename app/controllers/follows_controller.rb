class FollowsController < ApplicationController
  before_action :find_user

  def following
    @title = t ".title"
    @users = @user.following.page(params[:page])
                            .per Settings.user.per_of_page
    render :show_follow
  end
codeforces123
  def followers
    @title = t ".title"
    @users = @user.followers.page(params[:page])
                            .per Settings.user.per_of_page
    render :show_follow
  end

  private

  def find_user
    @user = User.find params[:id]
    return if @user

    flash[:danger] = t ".not_find_user"
    redirect_to root_url
  end
end
