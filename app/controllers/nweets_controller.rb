class NweetsController < ApplicationController
  # before_action :logged_in_user, only: [:create, :destroy] TODO!

  def create
    @nweet = current_user.nweets.build(new_nweet_params)
    if @nweet.save
      flash[:success] = "Nweet created!"
      redirect_to root_url
    else
      flash[:danger] = @nweet.errors.full_messages
      render 'pages/home'
    end
  end

  def destroy
  end

  def show
  end

  private
    # strong parameters
    def new_nweet_params
      params.require(:nweet).permit(:did_at)
    end
end
