class User::RelationshipsController < ApplicationController
  before_action :set_user
  include User::NotificationsHelper

  def create
    current_user.follow(@user)
    @users = current_user.following_user.page(params[:page]).sorted
    create_notification(current_user,
                        @user,
                        nil,
                        nil,
                        nil,
                        nil,
                        "follow")
  end

  def destroy
    current_user.unfollow(@user)
    @users = current_user.follower_user.page(params[:page]).sorted
  end

  def set_user
    @user = User.find(params[:user_nickname])
  end
end
