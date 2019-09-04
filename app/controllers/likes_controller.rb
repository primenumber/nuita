class LikesController < ApplicationController
  def create
    nweet = Nweet.find_by(url_digest: params[:nweet])
    @like = current_user.likes.create(nweet_id: nweet.id)
    # flash[:success] = nweet.user.handle_name + 'さんのヌイートをいいねしました！'
    head :no_content
  end

  def destroy
    nweet = Nweet.find_by(url_digest: params[:nweet])
    @like = Like.find_by(nweet_id: nweet.id, user_id: current_user.id)
    @like.destroy
    # flash[:danger] = 'ヌイートのいいねを解除しました……'
    head :no_content
  end
end
