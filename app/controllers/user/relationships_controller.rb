class User::RelationshipsController < ApplicationController
  before_action :set_user
  include User::NotificationsHelper

  def create
    current_user.follow(@user)
    create_notification(current_user, @user.id, nil, nil, nil, "follow")
  end

  def destroy
    current_user.unfollow(@user)
  end

  def set_user
    @user = User.find(params[:user_nickname])
  end
end
