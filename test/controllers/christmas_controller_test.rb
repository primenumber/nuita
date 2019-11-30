require 'test_helper'

class ChristmasControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get christmas_url
    assert_response :success
  end

  test "should get about" do
    get christmas_about_url
    assert_response :success
  end

end
