class CommentsController < ApplicationController

  def create
    @post = Post.find params[:post_id]
    comment_params = params.require(:comment).permit(:body)

    @comment = Comment.new(comment_params)
    @comment.post = @post
    @comment.user_id = session[:user_id]

    respond_to do |format|
      if @comment.save
        CommentsMailer.notify_post_owner(@comment).deliver_now
        format.html {redirect_to post_path(@post), notice: "Created Comment!"}
        format.js { render :create_success }
      else
        format.html { render post_path }
        format.js { render :create_failure }
      end
    end
  end

  def show
    @post = Post.find params[:post_id]
    @post.comments.order("created_at DESC")
  end

  def destroy
    @comment = Comment.find params[:id]
    @post = @comment.post
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to post_path(@post) }
      format.js { render }
    end
  end
end
