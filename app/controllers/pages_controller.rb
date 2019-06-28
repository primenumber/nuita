class PagesController < ApplicationController
  def home
    if user_signed_in?
      if params[:success] == 'true'
        @nweet = Nweet.find_by(url_digest: params[:url_digest])
      else
        @nweet = current_user.nweets.build
      end
      @feed_items = current_user.timeline.paginate(page: params[:page], per_page: 100)
    end
  end

  def favorites
    @feed_items = current_user.fav_nweets.paginate(page: params[:page], per_page: 100)
  end

  def about
  end
end
