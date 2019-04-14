class PagesController < ApplicationController
  def home
    if user_signed_in?
      @feed_items = current_user.timeline.paginate(page: params[:page])
    end
  end

  def about
  end
end
