require 'rails_helper'

RSpec.describe User, type: :model do
  user = User.new(name: 'Alice', photo: 'https://unsplash.com/photos/ABC123',
                  bio: 'Software Engineer from California.', post_counter: 10)

  describe 'User model' do
    context 'Validations for user' do
      it 'Should not allow an empty name for User' do
        user.name = nil
        expect(user).to_not be_valid
      end

      it 'Should return the existing name is valid' do
        user.name = 'Tom'
        expect(user).to be_valid
      end

      it 'Should not have a post_counter non-integer' do
        user.post_counter = 'Anything'
        expect(user).to_not be_valid
      end

      it 'Should allow post_counter to be an integer' do
        user.post_counter = 45
        expect(user).to be_valid
        user.post_counter = 0
        expect(user).to be_valid
      end

      it 'Should not allow integer to be zero' do
        user.post_counter = -3
        expect(user).to_not be_valid
      end
    end

    context 'User Method #three_recent_posts' do
      it 'return the three_recent_posts for a user' do
        first_user = User.create(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                                 bio: 'Teacher from Poland.')

        post1 = Post.create(author: first_user, title: 'First title', text: 'First Post', created_at: 4.hours.ago)
        post2 = Post.create(author: first_user, title: 'Second title', text: 'Second Post', created_at: 3.hours.ago)
        post3 = Post.create(author: first_user, title: 'Third title', text: 'Third Post', created_at: 2.hours.ago)
        post4 = Post.create(author: first_user, title: 'Fourth title', text: 'Fourth Post', created_at: 1.hours.ago)

        recent_posts = first_user.three_recent_posts

        expect(recent_posts).to eq([post4, post3, post2])
        expect(recent_posts).to_not include(post1)
      end
    end
  end
end
