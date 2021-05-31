class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.nickname = "ゲスト"
      user.password = SecureRandom.urlsafe_base64
      user.profile = "No Profile"
    end
  end
  with_options presence: true do
    validates :nickname
    validates :profile
  end
end
