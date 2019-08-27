class LinkCategory < ApplicationRecord
  belongs_to :link
  belongs_to :category

  validates :link_id, presence: :true
  validates :category_id, presence: :true
end
