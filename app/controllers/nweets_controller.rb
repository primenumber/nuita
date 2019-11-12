class NweetsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :correct_user, only: [:destroy, :update]

  def create
    @nweet = current_user.nweets.build(did_at: Time.zone.now)
    if @nweet.save # edit に移すべきかも
      redirect_to root_url(success: true, url_digest: @nweet.url_digest)
      tweet if current_user.autotweet_enabled
    else
      flash[:danger] = @nweet.errors.full_messages
      redirect_to root_url(success: false)
    end
  end

  def show
    @nweet = Nweet.find_by(url_digest: params[:url_digest])
    @detail = true
  end

  def destroy
    @nweet = Nweet.find_by(url_digest: params[:url_digest])
    @nweet.destroy
    flash[:success] = 'ヌイートを削除しました'
    redirect_to root_url
  end

  def update
    @nweet = Nweet.find_by(url_digest: params[:url_digest])

    if @nweet.update_attributes(edit_nweet_params)
      flash[:success] = 'ヌイートを更新しました'
      redirect_to root_url
    else
      flash[:danger] = @nweet.errors.full_messages
      redirect_to root_url
    end
  end

  private
    # strong parameters
    def edit_nweet_params
      params.require(:nweet).permit(:statement)
    end

    def correct_user
      @nweet = current_user.nweets.find_by(url_digest: params[:url_digest])
      redirect_to root_url if @nweet.nil?
    end
end
