class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
  has_many :book_comments, dependent: :destroy
  attachment :profile_image

  validates :title, { presence: true }
  validates :body, { presence: true, length: { maximum: 200 } }

  def self.create_all_ranks
    Book.find(Favorite.group(:book_id).order('count(book_id) desc').limit(10).pluck(:book_id))
  end
end
