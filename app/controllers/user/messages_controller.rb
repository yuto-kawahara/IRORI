class User::MessagesController < ApplicationController
  include User::MessagesHelper
  include User::NotificationsHelper

  def index
    @rooms = current_user.rooms
    @user_rooms = UserRoom.where(room_id: @rooms).sorted
    @user_rooms = @user_rooms.where.not(user_id: current_user.id)
  end

  def create
    @message = current_user.messages.new(message_params)
    @message.save
    users = @message.room.users
    user_id = users.where.not(id: current_user.id).first.id
    create_notification(current_user, user_id, nil, nil, @message.id, "message")
  end

  def show
    @user = User.find(params[:id])
    room_create_search(current_user, @user.id, "", "one")
  end

  private

  def message_params
    params.require(:message).permit(:content, :room_id)
  end
end
