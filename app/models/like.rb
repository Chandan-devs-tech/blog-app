class Like < ApplicationRecord
  belongs_to :user, class_name: 'User'
  belongs_to :post, class_name: 'Post'

  after_save :update_like_counter_post

  def update_like_counter_post
    post.update(likes_counter: post.likes.count)
  end
end
