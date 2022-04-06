class Post < ApplicationRecord
  belongs_to :user
  validates :image, presence: true
  mount_uploader :image, ImageUploader

  has_many :likes, dependent: :destroy
  has_many :like_users, through: :likes, source: :user
  has_many :comments, dependent: :destroy
  has_many :comment_posts, through: :comments, source: :user
end
