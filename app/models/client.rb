class Client < ApplicationRecord
  belongs_to :admin
  has_many :visits

  with_options presence: true do
    validates :name
    validates :tel
    validates :postal_code
    validates :address
  end
end
