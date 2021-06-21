class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.nickname = 'ゲスト'
      user.password = SecureRandom.urlsafe_base64
      user.profile = 'No Profile'
    end
  end
  def already_liked?(post)
    self.likes.exists?(post_id: post.id)
  end
  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes,    dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post
  has_one_attached :image

  has_many :following_relationships, foreign_key: "follower_id", class_name: "Relationship",  dependent: :destroy
  has_many :following, through: :following_relationships
  has_many :follower_relationships, foreign_key: "following_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :follower_relationships

  with_options presence: true do
    validates :nickname
    validates :profile
  end
  
  def following?(user)
    following_relationships.find_by(following_id: user.id)
  end

  def follow(user)
    following_relationships.create!(following_id: user.id)
  end

  def unfollow(user)
    following_relationships.find_by(following_id: user.id).destroy
  end
end
