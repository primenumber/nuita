require 'test_helper'

class CensoringsControllerTest < ActionDispatch::IntegrationTest
  include Warden::Test::Helpers

  def setup
    Warden.test_mode!
    @user = users(:chikuwa)
  end

  test "editing censoring require log in" do
    put censoring_path, params: {'r18g': '0', '3d': '0'}
    assert_redirected_to new_user_session_url

    login_as(@user)
    put censoring_path, params: {'r18g': '0', '3d': '0'}
    assert_redirected_to edit_user_registration_path(@user) # とりあえず成功してるってことで……
  end
end
