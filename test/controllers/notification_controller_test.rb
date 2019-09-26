require 'test_helper'

class NotificationControllerTest < ActionDispatch::IntegrationTest
  include Warden::Test::Helpers

  def setup
    Warden.test_mode!
    @user = users(:chikuwa)
    @other_user = users(:emiya)
    @nweet = nweets(:saytwo)
  end

  test "should get index when logged-in" do
    get notifications_path
    assert_redirected_to new_user_session_url

    login_as(@user)
    get notifications_path
    assert_response :success
  end

  test "should count unread notifications" do
    c = @other_user.passive_notifications.where(checked: false).count

    login_as(@user)
    post like_path, params: {nweet: @nweet.url_digest}

    login_as(@other_user)
    get root_url
    assert_select "#badgeUnreadNotifications", (c + 1).to_s

    get notifications_path
    assert_select "#badgeUnreadNotifications", false
  end
end
