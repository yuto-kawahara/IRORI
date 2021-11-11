class User::NotificationsController < ApplicationController
  def index
    @notifications = current_user.passive_notifications.sorted
    @notifications = @notifications.includes(:visitor,
                                             :visited,
                                             :recruit,
                                             :recruit,
                                             :message,
                                             :evaluation)
    @notifications = @notifications.valid.page(params[:page])
    @notifications.unread.each do |notification|
      notification.update_attribute(:checked, true)
    end
  end
end
