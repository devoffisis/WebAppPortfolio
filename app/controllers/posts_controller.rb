class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @pagy, @posts = pagy(Post.all)
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_url, notice: "投稿が保存されました。"
    else
      flash.now[:alert] = "投稿に失敗しました。"
      render :new
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_url, alert: "投稿を削除しました。"
  end

  private
  def post_params
    params.require(:post).permit(:caption, :image)
  end
end
