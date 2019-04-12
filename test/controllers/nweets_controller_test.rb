require 'test_helper'

class NweetsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @nweet = nweets(:today)
  end

  test 'should get show' do
    get nweet_path(@nweet)
    assert_response :success
  end

end
