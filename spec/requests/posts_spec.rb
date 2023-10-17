require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /posts' do
    context 'Get #index' do
      # before(:each) do
      #   get '/users/7/posts'
      # end
      user = User.create(name: 'Still Rollin', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                         bio: 'Singer from India', post_counter: 3)
      # Post.create(title: 'Hello World', author: user)

      it 'returns a 200 status code' do
        get user_posts_path(user)
        expect(response).to have_http_status(:success)
      end

      it 'open the index template' do
        get user_posts_path(user)
        expect(response).to render_template(:index)
      end

      it 'shows that template includes correct placeholder text' do
        get user_posts_path(user)
        expect(response.body).to include('Show all posts for a specific user')
      end
    end

    context 'Get #show' do
      # before(:each) do
      #   get '/users/7/posts/8'
      # end
      user = User.create(name: 'Still Rollin', photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
                         bio: 'Singer from India', post_counter: 3)
      post = Post.create(title: 'Hello World', author: user)

      it 'returns a 200 status code' do
        get user_post_path(user, post)
        expect(response).to have_http_status(:success)
      end

      it 'open the show template' do
        get user_post_path(user, post)
        expect(response).to render_template(:show)
      end

      it 'shows that template includes correct placeholder text' do
        get user_post_path(user, post)
        expect(response.body).to include('Specific post for a specific user')
      end
    end
  end
end
