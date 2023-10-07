require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'Method of Comment model' do
    it 'Should update the comments_counter of a post' do
      user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                         bio: 'Teacher from Mexico.')
      post = Post.create(author: user, title: 'Hello', text: 'This is my first post')
      comment = Comment.create(post:, user:, text: 'Hi Tom!')

      comment.update_comment_counter_post
      expect(post.reload.comments_counter).to eq(1)
    end
  end
end
