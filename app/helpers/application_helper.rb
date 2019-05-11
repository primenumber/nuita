require "uri"

module ApplicationHelper
  def text_url_to_link(text)
    URI.extract(text, ['http', 'https']).uniq.each do |url|
      sub_text = ""
      sub_text << "<a href=" << url << ">" << url << "</a>"

      text.gsub!(url, sub_text)
    end
    text
  end
end
