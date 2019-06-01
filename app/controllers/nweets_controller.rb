class NweetsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :correct_user, only: [:destroy, :update]

  def create
    @nweet = current_user.nweets.build(new_nweet_params)
    if @nweet.save # edit に移すべきかも
      redirect_to root_url(success: true, id: @nweet.id)
      tweet if current_user.autotweet_enabled
    else
      flash[:danger] = @nweet.errors.full_messages
      redirect_to root_url(success: false)
    end
  end

  def destroy
    @nweet = Nweet.find(params[:id])
    @nweet.destroy
    flash[:success] = 'ヌイートを削除しました'
    redirect_to root_url
  end

  def update
    @nweet = Nweet.find(params[:id])

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
    def new_nweet_params
      params.require(:nweet).permit(:did_at)
    end

    def edit_nweet_params
      params.require(:nweet).permit(:statement)
    end

    def correct_user
      @nweet = current_user.nweets.find_by(id: params[:id])
      redirect_to root_url if @nweet.nil?
    end
end
