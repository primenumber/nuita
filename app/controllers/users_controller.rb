class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @nweets = @user.nweets.paginate(page: params[:page], per_page: 50)
  end
end
