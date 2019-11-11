require 'test_helper'

class DeviseTest < ActionDispatch::IntegrationTest
  include Warden::Test::Helpers

  def setup
    Warden.test_mode!
    @user = users(:chikuwa)
  end

  test 'should show log-in' do
    get new_user_session_url
    assert_response :success
  end

  test 'should show sign-up' do
    get new_user_registration_url
    assert_response :success
  end

  test 'should show user edit' do
    get edit_user_registration_url
    assert_response 302

    login_as(@user)
    get edit_user_registration_url
    assert_response :success
  end
end
