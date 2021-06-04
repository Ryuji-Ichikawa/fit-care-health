class Post < ApplicationRecord
  belongs_to :user
  has_many :likes
  has_many :liked_users, through: :likes, source: :user
  has_one_attached :image
  has_many :comments, dependent: :destroy

  with_options presence: true do
    validates :title
    validates :catch_copy
    validates :concept
    validates :image
  end
end
