class VisitComment < ApplicationRecord
  belongs_to :user
  belongs_to :visit

  validates :comment, presence: true
end
