class CallComment < ApplicationRecord
  belongs_to :user
  belongs_to :call

  validates :comment, presence: true
end
