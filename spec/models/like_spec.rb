require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'Like Method' do
    it ' Should update likes_counter for a post' do
      user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                         bio: 'Teacher from Mexico.')
      post = Post.create(author: user, title: 'Hello', text: 'This is my first post')
      like = Like.create(user:, post:)
      like.update_like_counter_post
      expect(post.reload.likes_counter).to eq(1)
    end
  end
end
