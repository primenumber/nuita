class FavoritesController < ApplicationController
  def create
    nweet = Nweet.find_by(url_digest: params[:nweet])
    @favorite = current_user.favorites.create(nweet_id: nweet.id)
    flash[:success] = nweet.user.handle_name + 'さんのヌイートをいいねしました！'
    head :no_content
  end

  def destroy
    nweet = Nweet.find_by(url_digest: params[:nweet])
    @favorite = Favorite.find_by(nweet_id: nweet.id, user_id: current_user.id)
    @favorite.destroy
    flash[:danger] = 'ヌイートのいいねを解除しました……'
    head :no_content
  end
end
