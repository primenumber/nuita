require 'json'
require 'net/http'

class Link < ApplicationRecord
  before_create :fetch_infos

  has_many :nweet_links, dependent: :destroy
  has_many :nweets, through: :nweet_links

  validates :title, length: {maximum: 100}
  validates :description, length: {maximum: 500}

  validates :url, :url => true

  def refetch
    fetch_infos
    save
  end

  class << self
    def normalize_url(url)
      case url
      when /nijie/
        url.sub!(/sp.nijie/, 'nijie')
        url.sub(/view_popup/, 'view')
      when /melon/
        url + '&adult_view=1'
      else
        url
      end
    end
  end

  private

    def fetch_infos
      begin
        page = Nokogiri::HTML.parse(open(self.url).read)
        self.title = parse_title(page)
        self.description = parse_description(page)
        self.image = parse_image(page)
      rescue
        self.title = self.url
      end
    end

    def parse_title(page)
      if page.css('//meta[property="og:title"]/@content').empty?
        page.title.to_s.truncate(50)
      else
        page.css('//meta[property="og:title"]/@content').to_s.truncate(50)
      end
    end

    def parse_description(page)
      case self.url
      when /melonbooks/
        # スタッフの紹介文でidが分岐
        special_description = page.xpath('//div[@id="special_description"]//p/text()')
        if special_description.any?
          special_description.first.to_s.truncate(90)
        else
          description = page.xpath('//div[@id="description"]//p/text()')
          description.first.to_s.truncate(90)
        end
      else
        if page.css('//meta[property="og:description"]/@content').empty?
          page.css('//meta[name$="description"]/@content').to_s.truncate(90)
        else
          page.css('//meta[property="og:description"]/@content').to_s.truncate(90)
        end
      end
    end

    def parse_image(page)
      case self.url
      when /dlsite/
        page.css('//meta[property="og:image"]/@content').first.to_s.sub(/sam/, 'main')
      when /nijie/
        str = page.css('//script[@type="application/ld+json"]/text()').first.to_s

        if s = str.match(/https:\/\/pic.nijie.(net|info)\/(?<servername>\d+)\/[^\/]+\/nijie_picture\/(?<imagename>[^"]+)/)
          # 動画は容量大きすぎるし取らない
          if s[:imagename] =~ (/(jpg|png)/)
            'https://pic.nijie.net/' + s[:servername] + '/nijie_picture/' + s[:imagename]
          else
            s[0]
          end
        else
          page.css('//meta[property="og:image"]/@content').first.to_s
        end
      when /pixiv.*[^fanbox]illust_id=(\d+)/
        proxy_url = "https://pixiv.cat/#{$1}.jpg"
        # ↑で404だったら複数絵かも
        case Net::HTTP.get_response(URI.parse(proxy_url))
        when Net::HTTPNotFound
          proxy_url = "https://pixiv.cat/#{$1}-1.jpg"
        end

        proxy_url
      when /melonbooks/
        str = page.css('//meta[name="twitter:image"]/@content').first.to_s.sub(/&c=1/, '')
      else
        page.css('//meta[property="og:image"]/@content').first.to_s
      end
    end
end
