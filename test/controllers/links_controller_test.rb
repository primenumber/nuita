require 'test_helper'

class LinksControllerTest < ActionDispatch::IntegrationTest
  test 'fetch data correctly as created' do
    # hikakinTV
    url = 'https://www.youtube.com/user/HikakinTV'
    post link_path, params: {url: url}

    @link = Link.find_by(url: url)
    assert_not_nil @link

    assert_equal 'HikakinTV', @link.title
    assert_match 'ヒカキン', @link.description
    assert_not_empty @link.image

    # instagram
    url = 'https://www.instagram.com/'
    post link_path, params: {url: url}

    @link = Link.find_by(url: url)
    assert_not_nil @link

    assert_equal 'Instagram', @link.title
    assert_match 'Instagram', @link.description
    assert_not_empty @link.image

    # example.com (カード情報ない)
    url = 'http://example.com'
    post link_path, params: {url: url}

    @link = Link.find_by(url: url)
    assert_not_nil @link
    assert_equal 'Example Domain', @link.title
    assert_empty @link.description
  end

  test 'deal correctly with incorrect url' do
    url = 'http://val.id/'
    post link_path, params: {url: url}

    @link = Link.find_by(url: url)
    assert_equal @link.title, @link.url
  end
end
