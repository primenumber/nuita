require "uri"

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
end
