class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
helper_method :order_by_date
  def index

    @post = Post.all
    @user = User.new

    respond_to do |format|
	     format.html {render }
    end

  end

  def new
    @post = Post.new
  end

  def create
    post_params = params.require(:post).permit([:title, :blog, {tag_ids: []}])
    @post = Post.new(post_params)

      @post.user = current_user
    if @post.save
      redirect_to(posts_path)
    else
      render :new
    end
  end

  def edit

     @post = Post.find params[:id]
  end

  def update
     @post = Post.find params[:id]
    post_params = params.require(:post).permit([:title, :blog, {tag_ids: []}])


    if  @post.update(post_params)
      redirect_to(posts_path)
    else
      render :edit
    end
  end

  def show
    @post = Post.find params[:id]
      @comments = @post.comments.order("created_at DESC")
        @comment = Comment.new
          @like = @post.like_for(current_user)

  end
def edit_show
     @post = Post.find params[:id]
end

  def edit_in_show
    @post = Post.find params[:id]
   post_params = params.require(:post).permit([:title, :blog, {tag_ids: []}])


   if  @post.update(post_params)
     redirect_to(post_path(@post))
   else
     render :edit_in_show
   end
  end

  def destroy
    @post = Post.find params[:id]
    @post.destroy
    redirect_to posts_path
  end

end
