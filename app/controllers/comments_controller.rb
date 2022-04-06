class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = current_user.comments.build(post_params)
    if @comment.save
      redirect_to posts_url, notice: "コメントが保存されました。"
    else
      redirect_to posts_url, alert: "コメントに失敗しました。"
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:alert] = "コメントを削除しました"
    redirect_back(fallback_location: root_path)
  end

  private
  def post_params
    params.require("comment").permit(:user_id, :post_id, :comment)
  end
end
