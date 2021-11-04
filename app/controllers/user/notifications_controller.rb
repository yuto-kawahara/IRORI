class User::NotificationsController < ApplicationController
  def index
    @notifications = current_user.passive_notifications.sorted
    @notifications = @notifications.includes(:recruit, :recruit_comment, :message, :visitor)
    @notifications = @notifications.page(params[:page])
    @notifications.unread.each do |notification|
      notification.update_attribute(:checked, true)
    end
  end
end
