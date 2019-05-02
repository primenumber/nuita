module UsersHelper
  # change str to screen_name format ("Screen Name" -> "Screen_Name")
  def self.screen_name_formatter(str)
    str.gsub(/ /, '_')
  end

  # iconのイメージ返す　設定なしならデフォルト
  def icon_for(user, size: 80)
    if user.icon.url.present?
      url = user.icon.url
    else
      url = asset_path('icon_default')
    end
    image_tag(url, alt: user.handle_name, size: size.to_s, class:'usericon', id: "user-#{user.id}")
  end
end
