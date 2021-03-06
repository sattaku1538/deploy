class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  
  # ↓↓画像
  attachment :profile_image, destroy: false
  # ↓↓投稿バリデーション
  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }
  
  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  # ↓いいね機能のアソシエーション
  has_many :favorited_books, through: :favorites, source: :book
  
  # バリデーション
  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :email, presence: true
  validates :introduction, length: { maximum: 100 }, presence: true
   
  # 退会機能
  def active_for_authentication?
    super && (self.is_deleted == false)
  end
  
end
