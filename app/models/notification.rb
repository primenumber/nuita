class Notification < ApplicationRecord
  default_scope->{order(created_at: :desc)}
  enum action: [:like, :follow]

  belongs_to :like, optional: true
end
