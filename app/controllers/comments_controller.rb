class CommentsController < ApplicationController
  # load_and_authorize_resource
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
      redirect_to user_post_path(@post.author_id, @post)
    else
      flash[:alert] = 'Can not save the comment'
      render :new
    end
  end

  def destroy
    @user = current_user
    @comment = Comment.find(params[:id])
    @post = @comment.post
    if @comment.user == @user || @user.role == 'admin'
      @comment.destroy
      flash[:notice] = 'Comment successfully deleted.'
    else
      flash[:alert] = 'You are not authorized to delete this comment.'
    end
    redirect_to user_post_path(@post.author_id, @post.id)
  end

  private

  def comment_parameters
    params.require(:comment).permit(:text)
  end
end
