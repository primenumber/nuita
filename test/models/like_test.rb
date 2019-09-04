require 'test_helper'

class LikeTest < ActiveSupport::TestCase
  def setup
    @user = users(:chikuwa)
    @nweet = nweets(:today)
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
end
