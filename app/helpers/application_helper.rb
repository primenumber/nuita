require "uri"
require "nokogiri"
require "open-uri"

module ApplicationHelper
  def text_url_to_link(text)
    URI.extract(text, ['http', 'https']).uniq.each do |url|
      sub_text = ""
      sub_text << "<a href=" << url << " target='_blank'>" << url << "</a>"

      text.gsub!(url, sub_text)
    end
    text
  end

  # urlだけ返す
  def icon_url(user: current_user)
    if !user
      return asset_path('icon_default')
    end

    if user.icon.url.present?
      user.icon.url
    else
      url = asset_path('icon_default')
    end
  end

  # contribution graph用
  # collectionを渡すとcolumnの日ごとに整理されたhashになって返ってくる
  def calendarize_data(collection, column: :created_at)
    Hash.new([]).tap do |hash|
      collection.each do |c|
        date = c.send(column).to_date
        hash[date] = [] if hash[date].empty?
        hash[date] << c
      end
    end
  end

end
