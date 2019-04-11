require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:chikuwa)
  end

  test 'should get show' do
    get user_path(@user)
    assert_response :success
  end

  test 'associated nweets must be destroyed' do
    @user.save
    @user.nweets.create!(did_at: 1.minute.ago)
    assert_difference 'Nweet.count', -1 do
      @user.destroy
    end
  end
end
