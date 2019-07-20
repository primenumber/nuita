class Link < ApplicationRecord
  before_create :fetch_infos

  has_many :nweet_links, dependent: :destroy
  has_many :nweets, through: :nweet_links

  validates :url, :url => true

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
        page.title.to_s
      else
        page.css('//meta[property="og:title"]/@content').to_s
      end
    end

    def parse_description(page)
      if page.css('//meta[property="og:description"]/@content').empty?
        page.css('//meta[name$="description"]/@content').to_s.truncate(72)
      else
        page.css('//meta[property="og:description"]/@content').to_s.truncate(72)
      end
    end

    def parse_image(page)
      page.css('//meta[property="og:image"]/@content').to_s
    end
end
