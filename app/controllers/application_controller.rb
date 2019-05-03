class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
    # strong parameters
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:handle_name, :screen_name, :icon])
      devise_parameter_sanitizer.permit(:account_update, keys: [:handle_name, :screen_name, :icon])
    end

    def current_user?(user)
      current_user == @user
    end
end
