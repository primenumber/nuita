class TwittersController < ApplicationController
  def create
    current_user.add_twitter_account(request.env['omniauth.auth'])
    redirect_to edit_user_registration_path
  end

  def destroy
    current_user.delete_twitter_account
    redirect_to edit_user_registration_path
  end
end
