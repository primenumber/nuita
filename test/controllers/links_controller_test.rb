require 'test_helper'

class LinksControllerTest < ActionDispatch::IntegrationTest
  test 'fetch data correctly as created' do
    url = 'https://www.youtube.com/user/HikakinTV'
    post link_path, params: {url: url}

    @link = Link.find_by(url: url)
    assert_not_nil @link
  end
end
