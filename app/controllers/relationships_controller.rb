class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    user = User.find_by(url_digest: params[:followee])
    current_user.follow(user)
    head :no_content
  end

  def destroy
    user = User.find_by(url_digest: params[:followee])
    current_user.unfollow(user)
    head :no_content
  end
end
