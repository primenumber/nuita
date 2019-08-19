class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    user = User.find_by(url_digest: params[:followee])
    current_user.follow(user)
    if request.xhr?
      head :no_content
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    user = User.find_by(url_digest: params[:followee])
    current_user.unfollow(user)
    if request.xhr?
      head :no_content
    else
      redirect_back(fallback_location: root_path)
    end
  end
end
