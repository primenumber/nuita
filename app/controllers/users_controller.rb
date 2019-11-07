class UsersController < ApplicationController
  before_action :authenticate_user!, :friend_user, only: [:likes, :followers, :followees]

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
    @feed_items = @user.liked_nweets.paginate(page: params[:page], per_page: 100)
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

  def censorings
    begin
      Category.pluck(:name).each do |category_name|
        if current_user.censoring?(category_name)
          current_user.uncensor(category_name) if params[category_name] == '0'
        else
          current_user.censor(category_name) if params[category_name] == '1'
        end
      end
      flash[:success] = '検閲カテゴリの設定に成功しました'
    rescue => e
      flash[:danger] = "検閲カテゴリの設定に失敗しました: #{e}"
    ensure
      redirect_to edit_user_registration_path(current_user)
    end
  end

  private

    def friend_user
      @user = User.find_by(url_digest: params[:url_digest])
      unless @user == current_user || (@user.followee?(current_user) && @user.follower?(current_user))
        redirect_to(user_path(@user))
      end
    end

    def correct_user
      user = User.find_by(url_digest: params[:url_digest])
      unless user == current_user
        redirect_to(new_user_session_url)
      end
    end
end
