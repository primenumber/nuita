require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:chikuwa)
    @shinji = users(:shinji)
  end

  test 'should get show' do
    assert_not_equal user_path(@user), "/users/#{@user.id}"
    assert_equal user_path(@user), "/users/#{@user.url_digest}"

    get user_path(@user)
    assert_response :success
  end

  test 'associated nweets must be destroyed' do
    assert_difference 'Nweet.count', -1 do
      @shinji.destroy
    end
  end

  test 'nweets should have interval of 3 min' do
    @user.nweets.create!(did_at: 2.minutes.ago)
    nweet = @user.nweets.build(did_at: Time.zone.now)
    assert_not nweet.valid?
  end
end
