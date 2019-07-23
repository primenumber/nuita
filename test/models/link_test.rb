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

  test 'fetch pixiv correctly' do
    url = 'https://www.pixiv.net/member_illust.php?mode=medium&illust_id=75763842'
    @link = Link.create(url: url)

    assert_match '地鶏', @link.title
    assert_equal 'https://pixiv.cat/75763842.jpg', @link.image

    # これは完全に冗長なテストだけどかわいいから見て
    url = 'https://www.pixiv.net/member_illust.php?mode=medium&illust_id=73718144'
    @link = Link.create(url: url)

    assert_match 'んあー・・・', @link.title
    assert_match 'ん？あげませんよ！', @link.description
    assert_equal 'https://pixiv.cat/73718144.jpg', @link.image

    # manga. これで抜く人いなそう
    url = 'https://www.pixiv.net/member_illust.php?mode=medium&illust_id=75871400'
    @link = Link.create(url: url)

    assert_match 'DWU', @link.title
    assert_match '浅瀬', @link.description
    assert_equal 'https://pixiv.cat/75871400-1.jpg', @link.image
  end

  test 'deal correctly with incorrect url' do
    url = 'http://not-val.id/'
    @link = Link.create(url: url)

    assert_equal @link.url, @link.title
  end
end
