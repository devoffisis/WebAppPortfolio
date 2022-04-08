class FollowsController < ApplicationController
  def create
    follow = current_user.active_follows.build(follower_id: params[:user_id])
    follow.save
    flash[:notice] = "フォローしました"
    redirect_back(fallback_location: root_path)
  end

  def destroy
    follow = current_user.active_follows.find_by(follower_id: params[:user_id])
    follow.destroy
    flash[:notice] = "フォロー解除しました"
    redirect_back(fallback_location: root_path)
  end
end
