module CategoriesHelper
  # 検閲されてるタグの名前を返す. ないなら空集合返ってくる
  def censored_tags(link)
    if user_signed_in?
      link.categories.pluck(:name).select do |category|
        current_user.censoring?(category)
      end
    else
      link.categories.where(censored_by_default: true).pluck(:name)
    end
  end
end
