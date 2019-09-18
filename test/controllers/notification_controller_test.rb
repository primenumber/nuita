require 'test_helper'

class NotificationControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get notifications_path
    assert_response :success
  end

end
