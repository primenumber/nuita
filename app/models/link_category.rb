class LinkCategory < ApplicationRecord
  belongs_to :link
  belongs_to :category
end
