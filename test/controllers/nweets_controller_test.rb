require 'test_helper'

class NweetsControllerTest < ActionDispatch::IntegrationTest
  include Warden::Test::Helpers

  def setup
    Warden.test_mode!
    @nweet = nweets(:today)
    @friend_nweet = nweets(:yesterday)
    @user = users(:chikuwa)
  end

  test 'should redirect create when not logged in' do
    assert_no_difference 'Nweet.count' do
      post nweets_path, params: {nweet: {did_at: Time.zone.now}}
    end
    assert_redirected_to new_user_session_path
  end

  test 'should redirect destroy when not logged in' do
    assert_no_difference 'Nweet.count' do
      delete nweet_path(@nweet)
    end
    assert_redirected_to new_user_session_path
  end

  test 'logged-in user can create their own nweet' do
    login_as(@user)
    assert_difference('Nweet.count', 1) do
      post nweets_path, params: {nweet: {did_at: Time.zone.now}}
    end
    # post request doesn't contain user info, so no need to check correct user
  end

  test 'logged-in user can delete their own nweet' do
    login_as(@user)

    assert_no_difference('Nweet.count') do
      delete nweet_path(@friend_nweet)
    end

    assert_difference('Nweet.count', -1) do
      delete nweet_path(@nweet)
    end
  end

end
