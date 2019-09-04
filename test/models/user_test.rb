require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:chikuwa)
    @nweet = nweets(:today)
    @new_user = users(:girl)
  end

  test 'should be valid' do
    assert @user.valid?
  end

  test 'screen name should be valid' do
    @user.screen_name = " "
    assert_not @user.valid?

    @user.screen_name = "a" * 100
    assert_not @user.valid?

    @user.screen_name = "マイケル"
    assert_not @user.valid?
  end

  test 'handle name should be valid' do
    @user.handle_name = "a" * 100
    assert_not @user.valid?

    # handle name can be blank
    @user.handle_name = " "
    assert @user.valid?
  end

  test 'url_digest must be generated' do
    new_user = User.new(screen_name: "kaburanai", email: "kaburan@gmail.com", password: "hogehoge")
    new_user.save
    assert_not_empty new_user.url_digest
  end

  test 'associated nweets must be destroyed' do
    @new_user.save
    @new_user.nweets.create!(did_at: Time.zone.now)
    assert_difference 'Nweet.count', -1 do
      @new_user.destroy
    end
  end

  test 'associated likes must be destroyed' do
    @new_user.save
    @new_user.likes.create!(nweet: @nweet)
    assert_difference 'Like.count', -1 do
      @new_user.destroy
    end
  end

  test 'should follow and unfollow a user' do
    assert_not @user.followee?(@new_user)
    @user.follow(@new_user)
    assert @user.followee?(@new_user)
    assert @new_user.follower?(@user)
    @user.unfollow(@new_user)
    assert_not @new_user.followee?(@user)
  end
end
