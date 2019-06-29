class UsersController < ApplicationController
  def show
    @user = User.find_by(url_digest: params[:url_digest])
    @nweets = @user.nweets.paginate(page: params[:page], per_page: 50)
  end

  def likes
    @user = User.find_by(url_digest: params[:url_digest])
    @feed_items = @user.fav_nweets.paginate(page: params[:page], per_page: 100)
  end
end
