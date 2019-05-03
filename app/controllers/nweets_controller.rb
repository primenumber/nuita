class NweetsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :correct_user, only: [:destroy]

  def create
    @nweet = current_user.nweets.build(new_nweet_params)
    if @nweet.save
      redirect_to root_url(success: true)
    else
      flash[:danger] = @nweet.errors.full_messages
      redirect_to root_url(success: false)
    end
  end

  def destroy
    @nweet.destroy
    flash[:success] = 'ヌイートを削除しました'
    redirect_to root_url
  end

  def show
  end

  private
    # strong parameters
    def new_nweet_params
      params.require(:nweet).permit(:did_at)
    end

    def correct_user
      @nweet = current_user.nweets.find_by(id: params[:id])
      redirect_to root_url if @nweet.nil?
    end
end
