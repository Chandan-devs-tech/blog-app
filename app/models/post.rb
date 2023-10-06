class Post < ApplicationRecord
  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes

  after_save :update_posts_counter_user
  after_initialize :set_counters_to_zero

  def set_counters_to_zero
    self.comments_counter ||= 0
    self.likes_counter ||= 0
  end

  def update_posts_counter_user
    author.update(post_counter: author.posts.count)
  end

  def five_recent_comments_post
    comments.order(created_at: :desc).limit(5)
  end
end
