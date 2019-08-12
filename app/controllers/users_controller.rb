class UsersController < ApplicationController
  before_action :friend_user, only: [:likes, :followers, :followees]

  def show
    @user = User.find_by(url_digest: params[:url_digest])
    @nweets = @user.nweets.paginate(page: params[:page], per_page: 50)
  end

  def likes
    @user = User.find_by(url_digest: params[:url_digest])

    redirect_to root_url unless @user == current_user

    @feed_items = @user.fav_nweets.paginate(page: params[:page], per_page: 100)
  end

  def followers
    render 'show_follow'
  end

  def followees
    render 'show_follow'
  end

  private

    def friend_user
      @user = User.find_by(url_digest: params[:url_digest])
      unless @user == current_user || (@user.followee?(current_user) && @user.follower?(current_user))
        redirect_to(root_url)
      end
    end
end
