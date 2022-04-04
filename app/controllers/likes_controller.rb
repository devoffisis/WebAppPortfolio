class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    current_user.favorite(@post)
    flash[:notice] = "いいねしました"
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @post = Post.find(params[:post_id])
    current_user.unfavorite(@post)
    flash[:alert] = "いいね解除しました"
    redirect_back(fallback_location: root_path)
  end
end
