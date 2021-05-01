class Visit < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  belongs_to :client
  belongs_to :status
  has_many   :visit_comments, dependent: :destroy

  with_options presence: true do
    validates :title
    validates :date
    validates :content
  end
  
  validates :status_id, numericality: { other_than: 1, message: 'を選択してください' }

end
