require 'test_helper'

class NweetTest < ActiveSupport::TestCase
  def setup
    @user = users(:chikuwa)
    @nweet = @user.nweets.build(did_at: Time.zone.now)
  end

  test 'should be valid' do
    assert @nweet.valid?
  end

  test 'user id should be present' do
    @nweet.user_id = nil
    assert_not @nweet.valid?
  end

  test 'did_at should be present (I mean, past)' do
    @nweet.did_at = nil
    assert_not @nweet.valid?

    @nweet.did_at = 1.day.since
    assert_not @nweet.valid?

    @nweet.did_at = 1.hour.ago
    assert @nweet.valid?
  end

  test 'nweet should be most recent first' do
    assert_equal nweets(:modasho), Nweet.first
    assert_equal nweets(:saytwo), Nweet.last
  end

  test 'statement should be valid' do
    @nweet.statement = nil
    assert @nweet.valid?

    @nweet.statement = 'a' * 150
    assert_not @nweet.valid?

    @nweet.statement = '誰だ今の'
    assert @nweet.valid?
  end
end
