class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :nickname
    validates :last_name
    validates :first_name
    validates :last_name_kana
    validates :first_name_kana
    validates :birthday
  end

  validates :password,
            format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i, message: 'は半角英数の両方を使用してください' }
  validates :last_name, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]/, message: 'は全角文字で入力してください' }
  validates :first_name, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]/, message: 'は全角文字で入力してください' }
  validates :last_name_kana, format: { with: /\A[ァ-ヶー－]+\z/, message: 'は全角カナ文字で入力してください' }
  validates :first_name_kana, format: { with: /\A[ァ-ヶー－]+\z/, message: 'は全角カナ文字で入力してください' }

  has_many :items
  has_many :purchases
end
