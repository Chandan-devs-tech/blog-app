class Api::V1::PostsController < ApplicationController
  def index
    @posts = User.find(params[:user_id]).posts
    pretty_json = JSON.pretty_generate(success: true, data: { posts: @posts.as_json })
    render json: pretty_json, status: :ok
  end
end
