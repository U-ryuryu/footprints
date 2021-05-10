class Client < ApplicationRecord
  belongs_to :admin
  has_many :visits, dependent: :destroy
  has_many :calls,  dependent: :destroy

  with_options presence: true do
    validates :name
    validates :tel, length: { maximum: 11 }
    validates :postal_code
    validates :address
  end

  validates :tel, numericality: { only_integer: true, message: '半角数字のみで入力してください' }, if: proc { |client|client.tel.present?}
  validates :charge_tel, numericality: { only_integer: true, message: '半角数字のみで入力してください' }, length: { maximum: 11 }, if: proc { |client|client.charge_tel.present?}


  validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: 'はハイフン(-)を含む半角数字7桁で入力してください' },if: proc { |client|client.postal_code.present?}

  def self.search(search)
    if search != ""
      Client.where("name LIKE(?)", "%#{search}%")
    else
      Client.all
    end
  end
end
