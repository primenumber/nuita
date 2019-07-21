require 'test_helper'

class LinkTest < ActiveSupport::TestCase
  test 'fetch data correctly as created' do
    # hikakinTV
    url = 'https://www.youtube.com/user/HikakinTV'
    @link = Link.create(url: url)
    assert_not_nil @link

    assert_equal 'HikakinTV', @link.title
    assert_match 'ヒカキン', @link.description
    assert_not_empty @link.image

    # instagram
    url = 'https://www.instagram.com/'
    @link = Link.create(url: url)
    assert_not_nil @link

    assert_equal 'Instagram', @link.title
    assert_match 'Instagram', @link.description
    assert_not_empty @link.image

    # example.com (カード情報ない)
    url = 'http://example.com'
    @link = Link.create(url: url)
    assert_not_nil @link
    assert_equal 'Example Domain', @link.title
    assert_empty @link.description
  end

  test 'fetch nijie correctly' do
    url = 'https://sp.nijie.info/view_popup.php?id=319985'
    url = Link.normalize_url(url)
    @link = Link.create(url: url)

    assert_equal 'https://nijie.info/view.php?id=319985', @link.url
    assert_match '発情めめめ', @link.title

    url = 'https://nijie.info/view.php?id=319985'
    url = Link.normalize_url(url)
    assert_no_difference 'Link.count' do
      @link = Link.create(url: url)
    end
  end

  test 'deal correctly with incorrect url' do
    url = 'http://not-val.id/'
    @link = Link.create(url: url)

    assert_equal @link.url, @link.title
  end
end
