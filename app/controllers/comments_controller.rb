class CommentsController < ApplicationController
  def new
    @user = current_user
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def create
    @user = current_user
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_parameters)
    @comment.user_id = @user.id
    @comment.post_id = @post.id

    if @comment.save
      flash[:notice] = 'The post is successfully submitted'
      redirect_to user_post_path(@user, @post)
    else
      flash[:alert] = 'Can not save the comment'
      render :new
    end
  end

  private

  def comment_parameters
    params.require(:comment).permit(:text)
  end
end
