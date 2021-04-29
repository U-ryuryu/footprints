class Visit < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :client
  belongs_to :status
end
