class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def tweet(content = render_tweet(current_user.autotweet_content))
    begin
      current_user.tweet(content)
    rescue
      flash[:warning] = 'ツイートに失敗しました。Twitterアカウントの状態を確認してください。'
    end
  end

  protected
    # strong parameters
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:handle_name, :screen_name, :icon])
      devise_parameter_sanitizer.permit(:account_update, keys: [:handle_name, :screen_name, :icon, :autotweet_enabled, :autotweet_content, :biography])
    end

    def current_user?(user)
      current_user == @user
    end

    # generate content of tweet from user-specific template
    def render_tweet(nweet)
      current_user.autotweet_content.gsub(/\[LINK\]/, nweet_url(@nweet))
    end
end
