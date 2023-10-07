class User < ApplicationRecord
  validates :name, presence: true
  validates :post_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  has_many :posts, foreign_key: 'author_id', class_name: 'Post'
  has_many :comments, foreign_key: 'user_id', class_name: 'Comment'
  has_many :likes, foreign_key: 'user_id', class_name: 'Like'

  after_initialize :set_post_counter_zero

  def set_post_counter_zero
    self.post_counter ||= 0
  end

  def three_recent_posts
    posts.order(created_at: :desc).limit(3)
  end
end
