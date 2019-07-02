class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:likes]

  def show
    @user = User.find_by(url_digest: params[:url_digest])
    @nweets = @user.nweets.paginate(page: params[:page], per_page: 50)
  end

  def likes
    @user = User.find_by(url_digest: params[:url_digest])

    redirect_to root_url unless @user == current_user

    @feed_items = @user.fav_nweets.paginate(page: params[:page], per_page: 100)
  end
end
