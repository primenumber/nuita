module CategoriesHelper
  def censored?(link)
    names = link.categories.where(censored_by_default: true).pluck(:name)
    if names.empty? #これもっとうまく書けるきがする
      false
    else
      names
    end
  end
end
