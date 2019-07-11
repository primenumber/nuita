require 'test_helper'

class FavlineTest < ActionDispatch::IntegrationTest
  include Warden::Test::Helpers

  def setup
    Warden.test_mode!
    @user = users(:chikuwa)
    @nweet = nweets(:yesterday)

    login_as(@user)
  end

  test 'favline test' do
    post favorite_path, params: {nweet: @nweet.url_digest}

    # it is really a shame that fav and like are both used
    get likes_user_path(url_digest: @user.url_digest)
    assert_select "a[href=?]", nweet_path(@nweet)

    deleted_nweet_path = nweet_path(@nweet)

    delete favorite_path, params: {nweet: @nweet.url_digest}

    get likes_user_path(url_digest: @user.url_digest)
    assert_select "a[href=?]", deleted_nweet_path, false
  end
end
