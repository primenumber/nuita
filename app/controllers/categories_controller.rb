class CategoriesController < ApplicationController
  before_action :authenticate_user!

  def create
    link = Link.find(params[:link_id])
    link.set_category(params[:category_name])
  end

  def destroy
    link = Link.find(params[:link_id])
    link.remove_category(params[:category_name])
  end
end
