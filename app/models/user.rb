class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true, length: { maximum: 50 }
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_posts, through: :likes, source: :post
  has_many :comments, dependent: :destroy
  has_many :comment_posts, through: :comments, source: :post

  def favorite(post)
    self.likes.find_or_create_by(post_id: post.id)
  end

  def unfavorite(post)
    like = self.likes.find_by(post_id: post.id)
    like.destroy if like
  end

  def favorite?(post)
    self.like_posts.include?(post)
  end

  def comment(user_id, post_id)
    self.comments.create(user_id: user_id, post_id: post_id, comment: params[:comment])
  end
end
