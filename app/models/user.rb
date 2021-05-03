class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :admin
  has_many   :visits,         dependent: :destroy
  has_many   :calls,          dependent: :destroy
  has_many   :visit_comments, dependent: :destroy
  has_many   :call_comments,  dependent: :destroy

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  
  validates :name, presence: true
  validates :password, format: { with: PASSWORD_REGEX, message: 'は半角英数字の組合せで入力してください' }, if: proc { |user|user.password.present?}
end
