class PostsController < ApplicationController
  # load_and_authorize_resource
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments)
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
  end

  def new
    @user = User.find(params[:user_id])
    @post = Post.new
  end

  def create
    @user = current_user
    @post = Post.new(post_parameters)
    @post.author_id = @user.id

    if @post.save
      flash[:notice] = 'The post is successfully submitted'
      redirect_to user_post_path(@user, @post)
    else
      flash[:alert] = 'Can not save the post'
      render :new
    end
  end

  def destroy
    @user = current_user
    @post = Post.includes(:likes).find(params[:id])
    if @post.author == @user || @user.role == 'admin'
      @post.likes.destroy_all
      @post.comments.destroy_all
      @post.destroy!
      flash[:notice] = 'Post successfully deleted.'
    else
      flash[:alert] = 'You are not authorized to delete this Post.'
    end
    redirect_to user_posts_path(id: @user.id)
  end

  private

  def post_parameters
    params.require(:post).permit(:title, :text)
  end
end
