class Category < ApplicationRecord
  validates :name, presence: true, length: {maximum: 30}, :uniqueness => {case_sensitive: false}

  has_many :link_categories, dependent: :destroy
  has_many :links, through: :link_categories

  before_save :set_censored_by_default
  before_validation { name.upcase! }

  private

    def set_censored_by_default
      censor_list = ['R18G', '3D']

      if censor_list.include?(name)
        self.censored_by_default = true
      end
    end
end
