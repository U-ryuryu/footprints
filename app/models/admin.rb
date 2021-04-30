class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :users, dependent: :destroy
  has_many :clients, dependent: :destroy

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze

  validates :name, presence: true
  validates :password, format: { with: PASSWORD_REGEX, message: 'は半角英数字の組合せで入力してください' }, if: proc { |admin|admin.password.present?}
end
