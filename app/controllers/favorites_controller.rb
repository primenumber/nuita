class FavoritesController < ApplicationController
  def create
    nweet = Nweet.find_by(url_digest: params[:nweet])
    @favorite = current_user.favorites.create(nweet_id: nweet.id)
    redirect_back(fallback_location: root_path)
  end

  def destroy
  end
end
