class Post < ApplicationRecord
  with_options dependent: :destroy do
    has_many :comments
    has_many :likes
    has_many :tag_maps
  end
  belongs_to :user
  has_many :liked_users, through: :likes, source: :user
  has_many :tags, through: :tag_maps
  has_one_attached :image

  with_options presence: true do
    validates :title
    validates :catch_copy
    validates :concept
    validates :image
  end
end
