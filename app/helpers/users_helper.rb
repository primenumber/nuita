module UsersHelper
  # change str to screen_name format ("Screen Name" -> "Screen_Name")
  def self.screen_name_formatter(str)
    str.gsub(/ /, '_')
  end

  # iconのイメージ返す　設定なしならデフォルト
  def icon_for(user, size: 80, htmlclass: 'usericon')
    if !user
      return image_tag(asset_path('icon_default'), size: size.to_s, class:'usericon', id: 'usericon-new')
    end

    if user.icon.url.present?
      url = user.icon.url
    else
      url = asset_path('icon_default')
    end
    image_tag(url, alt: user.handle_name, size: size.to_s, class: htmlclass, id: "usericon-#{user.id}")
  end

  def current_user?(user)
    user == current_user
  end

  def friend?(user)
    user == current_user || (user.followee?(current_user) && user.follower?(current_user))
  end

  # 「自分がログイン済みで、かつ相手が自分以外のユーザーかどうか」
  def other_user?(user)
    !!current_user && current_user != user
  end
end
