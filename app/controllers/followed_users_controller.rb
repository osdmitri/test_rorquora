class FollowedUsersController < ApplicationController
  def follow
    redirect_to :new_user_session && return unless user_signed_in?

    @user = User.find(params[:id])
    current_user.followed_users.where(to: @user).first_or_create

    redirect_to root_path
  end

  def followed
    redirect_to :new_user_session && return unless user_signed_in?

    @users = FollowedUser.select(:to_id).where(user: current_user)
    @questions = Question.where(user: @users)

    render 'questions/index'
  end

  def unfollow
    redirect_to :new_user_session && return unless user_signed_in?

    current_user.followed_users.where(to: params[:id]).delete_all
    redirect_to root_path
  end
end
