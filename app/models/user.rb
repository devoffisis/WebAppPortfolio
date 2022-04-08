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

  # cf. https://qiita.com/kazukimatsumoto/items/14bdff681ec5ddac26d1
  # フォロワーから見てフォロイーを集める
  has_many :active_follows, class_name: "Follow", foreign_key: :following_id
  has_many :followings, through: :active_follows, source: :follower
  # フォロイーから見てフォロワーを集める
  has_many :passive_follows, class_name: "Follow", foreign_key: :follower_id
  has_many :followers, through: :passive_follows, source: :following

  def followed_by?(user)
    passive_follows.find_by(following_id: user.id).present?
  end

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
