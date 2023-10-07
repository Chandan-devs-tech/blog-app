require 'rails_helper'

RSpec.describe Post, type: :model do
  user = User.create(name: 'Harry')
  post = Post.new(title: 'Hi', text: 'My first post', comments_counter: 5, likes_counter: 2, author: user)

  describe 'Post Model' do
    context 'Checking the post title' do
      it 'Should not allow empty title' do
        post.title = nil
        expect(post).to_not be_valid
      end

      it 'Should not allow a title not more than 250 chars' do
        post.title = 'Hello' * 50
        expect(post).to be_valid
      end
    end

    context 'For checking the comments_counter' do
      it 'Should not allow non integer value for comments_counter' do
        post.comments_counter = 'Anything'
        expect(post).to_not be_valid
      end

      it 'Should allow integer value for comments_counter' do
        post.comments_counter = 4
        expect(post).to be_valid
      end
    end

    context 'For checking the likes_counter' do
      it 'Should not allow non integer value for likes_counter' do
        post.likes_counter = 'Anything'
        expect(post).to_not be_valid
      end

      it 'Should allow integer value for likes_counter' do
        post.likes_counter = 4
        expect(post).to be_valid
      end

      it 'Should not allow negative integer value for likes_counter' do
        post.likes_counter = -4
        expect(post).to_not be_valid
      end
    end

    context 'Methods of post.rb' do
      it 'Should update post_counter when a new post is created' do
        user = User.create(name: 'Chandan')
        post = Post.create(title: 'Hello World', author: user)

        post.update_posts_counter_user

        expect(user.post_counter).to eq(1)
      end

      it 'Should show the 5 recent comments of a post' do
        user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                           bio: 'Teacher from Mexico.')
        post = Post.create(author: user, title: 'Hello', text: 'This is my first post')
        comment1 = Comment.create(post:, user:, text: 'Hi There!', created_at: 6.hours.ago)
        comment2 = Comment.create(post:, user:, text: 'Hello There!', created_at: 5.hours.ago)
        comment3 = Comment.create(post:, user:, text: 'This is Chandan!', created_at: 4.hours.ago)
        comment4 = Comment.create(post:, user:, text: 'Coding is challanging!',
                                  created_at: 3.hours.ago)
        comment5 = Comment.create(post:, user:, text: 'But practice!', created_at: 2.hours.ago)
        comment6 = Comment.create(post:, user:, text: 'Bye!', created_at: 1.hours.ago)
        expect(post.five_recent_comments_post).to eq([comment6, comment5, comment4, comment3, comment2])
        expect(post.five_recent_comments_post).to_not include(comment1)
      end
    end

    context 'Custom Method: #set_counters_to_zero' do
      it 'should set comments_counter to 0 when comments_counter is nil' do
        post = Post.new(title: 'My name is Chandan')
        post.set_counters_to_zero
        expect(post.comments_counter).to eq(0)
      end

      it 'should set likes_counter to 0 when likes_counter is nil' do
        post = Post.new(title: 'I am from India')
        post.set_counters_to_zero
        expect(post.likes_counter).to eq(0)
      end

      it 'should not change comments_counter if it is already set' do
        post = Post.new(title: 'I like to code!', comments_counter: 3)
        post.set_counters_to_zero
        expect(post.comments_counter).to eq(3)
      end

      it 'should not change likes_counter if it is already set' do
        post = Post.new(title: 'That is all', likes_counter: 40)
        post.set_counters_to_zero
        expect(post.likes_counter).to eq(40)
      end
    end
  end
end
