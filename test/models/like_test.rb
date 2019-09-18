require 'test_helper'

class LikeTest < ActiveSupport::TestCase
  def setup
    @user = users(:chikuwa)
    @nweet = nweets(:today)
    @other_nweet = nweets(:saytwo)
  end

  test 'user can like nweet only once' do
    # user can like
    like = @user.likes.create!(nweet: @nweet)
    assert @user.liked?(@nweet)

    # but not twice
    another_like = @user.likes.build(nweet: @nweet)
    assert_not another_like.valid?

    # but after deleting first one...
    like.destroy
    assert another_like.valid?
  end

  test 'like creates and destroys notification' do
    like = @user.likes.create!(nweet: @other_nweet)
    notification = like.notification

    assert notification.like? # 通知の種類(=action)のテスト
    assert_equal @user.id, notification.origin_id
    assert_equal @other_nweet.user.id, notification.destination_id

    assert_difference('Notification.count', -1) do
      like.destroy
    end
  end
end
