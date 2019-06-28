require 'test_helper'

class FavoriteTest < ActiveSupport::TestCase
  def setup
    @user = users(:chikuwa)
    @nweet = nweets(:today)
  end

  test 'user can favorite nweet only once' do
    # user can fav
    fav = @user.favorites.create!(nweet: @nweet)
    assert @user.faved?(@nweet)

    # but not twice
    another_fav = @user.favorites.build(nweet: @nweet)
    assert_not another_fav.valid?

    # but after deleting first one...
    fav.destroy
    assert another_fav.valid?
  end
end
