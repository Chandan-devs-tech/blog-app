class User < ApplicationRecord
  has_many :posts, foreign_key: 'author_id'
  has_many :comments, foreign_key: 'comment_id'
  has_many :likes, foreign_key: 'like_id'

  def three_recent_posts
    posts.order(created_at: :desc).limit(3)
  end
end
