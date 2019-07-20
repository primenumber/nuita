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
      if page.css('//meta[property="og:description"]/@content').empty?
        page.css('//meta[name$="description"]/@content').to_s.truncate(90)
      else
        page.css('//meta[property="og:description"]/@content').to_s.truncate(90)
      end
    end

    def parse_image(page)
      case self.url
      when /dlsite/
        page.css('//meta[property="og:image"]/@content').first.to_s.sub(/sam/, 'main')
      else
        page.css('//meta[property="og:image"]/@content').first.to_s
      end
    end
end
