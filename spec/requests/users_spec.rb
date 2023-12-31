require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /users' do
    context 'Get #index' do
      before(:each) do
        get '/users'
      end
      it 'returns a 200 status code' do
        expect(response).to have_http_status(:success)
      end

      it 'open the index template' do
        expect(response).to render_template(:index)
      end

      it 'shows that template includes correct placeholder text' do
        expect(response.body).to include('List of all users')
      end
    end

    context 'Get #show' do
      before(:each) do
        get '/users/7'
      end
      it 'returns a 200 status code' do
        expect(response).to have_http_status(:success)
      end

      it 'open the show template' do
        expect(response).to render_template(:show)
      end

      it 'shows that template includes correct placeholder text' do
        expect(response.body).to include('Show a specific user')
      end
    end
  end
end
