require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'Method of Comment model' do
    it 'Should update the comments_counter of a post' do
      first_user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                               bio: 'Teacher from Mexico.')
      first_post = Post.create(author: first_user, title: 'Hello', text: 'This is my first post')
      comment = Comment.create(post: first_post, user: first_user, text: 'Hi Tom!')

      comment.update_comment_counter_post
      expect(first_post.reload.comments_counter).to eq(1)
    end
  end
end
