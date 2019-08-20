class UsersController < ApplicationController
  before_action :friend_user, only: [:likes]
  before_action :correct_user, only: [:followers, :followees]

  def show
    @user = User.find_by(url_digest: params[:url_digest])
    if params[:date]
      @nweets = @user.nweets_at_date(params[:date].to_time).paginate(page: params[:page])
    else
      @nweets = @user.nweets.paginate(page: params[:page], per_page: 50)
    end
  end

  def likes
    @user = User.find_by(url_digest: params[:url_digest])
    @feed_items = @user.fav_nweets.paginate(page: params[:page], per_page: 100)
  end

  def followers
    @topic = 'フォロワー'
    @user = User.find_by(url_digest: params[:url_digest])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  def followees
    @topic = 'フォロー'
    @user = User.find_by(url_digest: params[:url_digest])
    @users = @user.followees.paginate(page: params[:page])
    render 'show_follow'
  end

  private

    def friend_user
      @user = User.find_by(url_digest: params[:url_digest])
      unless @user == current_user || (@user.followee?(current_user) && @user.follower?(current_user))
        redirect_to(new_user_session_url)
      end
    end

    def correct_user
      user = User.find_by(url_digest: params[:url_digest])
      unless user == current_user
        redirect_to(new_user_session_url)
      end
    end
end
