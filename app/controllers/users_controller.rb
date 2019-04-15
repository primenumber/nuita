class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @nweets = @user.nweets.paginate(page: params[:page])
  end
end
