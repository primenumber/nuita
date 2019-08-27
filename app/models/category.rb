class Category < ApplicationRecord
  validates :name, presence: true, length: {maximum: 30}

  has_many :link_categories, dependent: :destroy
  has_many :links, through: :link_categories

  before_save :set_censored_by_default

  private

    def set_censored_by_default
      censor_list = ['R-18G', '3D']

      if censor_list.include?(name)
        censored_by_default = true
      end
    end
end
