require 'test_helper'

class FolloweeTest < ActionDispatch::IntegrationTest
  include Warden::Test::Helpers

  def setup
    Warden.test_mode!
    @user = users(:chikuwa)
    @other_user = users(:shinji)
    @nweet = @other_user.nweets.first # nweets(:yesterday)

    login_as(@user)
  end

  test 'show and hide statement due to relationship' do
    get root_path
    assert_no_match @nweet.statement, response.body

    post relationship_path(followee: @other_user)
    get root_path
    assert_match @nweet.statement, response.body
  end

  test 'show statement if not timeline' do
    get nweet_path(@nweet)
    assert_match @nweet.statement, response.body

    get user_path(@nweet.user)
    assert_match @nweet.statement, response.body
  end
end
