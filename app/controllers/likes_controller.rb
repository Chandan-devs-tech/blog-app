class LikesController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
    @like = Like.new
  end

  def create
    @user = current_user
    @post = Post.find(params[:post_id])
    @like = Like.new(user_id: @user.id, post_id: @post.id)

    if @like.save
      flash[:notice] = 'The like is successfully submitted'
      redirect_to user_post_path(@user, @post)
    else
      flash[:alert] = 'Can not save the like'
      render :new
    end
  end
end
