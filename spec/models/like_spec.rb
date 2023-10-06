require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'Like Method' do
    it ' Should update likes_counter for a post' do
      first_user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                               bio: 'Teacher from Mexico.')
      first_post = Post.create(author: first_user, title: 'Hello', text: 'This is my first post')
      like = Like.create(user: first_user, post: first_post)
      like.update_like_counter_post
      expect(first_post.reload.likes_counter).to eq(1)
    end
  end
end
