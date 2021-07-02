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

  #タグを保存する処理
  def save_tag(sent_tags)
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    old_tags = current_tags - sent_tags
    new_tags = sent_tags - current_tags

    #古いタグの削除
    old_tags.each do |old|
      self.tags.delete Tag.find_by(tag_name: old)
    end

    #新しいタグの保存
    new_tags.each do |new|
      new_post_tag = Tag.find_or_create_by(tag_name: new)
      self.tags << new_post_tag
    end
  end
end
