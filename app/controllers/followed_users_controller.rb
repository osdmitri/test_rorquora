class FollowedUsersController < ApplicationController
  def follow
    redirect_to :new_user_session && return unless user_signed_in?

    @user = User.find(params[:id])
    current_user.followed_users.where(to: @user).first_or_create

    redirect_to root_path
  end

  def unfollow
    redirect_to :new_user_session && return unless user_signed_in?

    current_user.followed_users.where(to: params[:id]).delete_all
    redirect_to root_path
  end
end
