class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # ゲスト機能のモデル
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.nickname = 'ゲスト'
      user.password = SecureRandom.urlsafe_base64
      user.profile = 'No Profile'
    end
  end

  # いいね機能のモデル
  def already_liked?(post)
    likes.exists?(post_id: post.id)
  end

  with_options dependent: :destroy do
    has_many :posts
    has_many :comments
    has_many :likes
    has_many :following_follows, foreign_key: 'follower_id', class_name: 'Follow'
    has_many :follower_follows, foreign_key: 'following_id', class_name: 'Follow'
  end

  has_many :liked_posts, through: :likes, source: :post
  has_many :followings, through: :following_follows
  has_many :followers, through: :follower_follows
  has_one_attached :image

  with_options presence: true do
    validates :nickname
    validates :profile
  end
  # フォロー機能のモデル
  def following?(user)
    following_follows.find_by(following_id: user.id)
  end

  def follow(user)
    following_follows.create!(following_id: user.id)
  end

  def unfollow(user)
    following_follows.find_by(following_id: user.id).destroy
  end
end
