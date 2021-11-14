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
    # 未読の通知がある場合は既読に更新
    @notifications.unread.each do |notification|
      notification.update_attribute(:checked, true)
    end
  end
end
