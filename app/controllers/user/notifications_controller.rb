class User::NotificationsController < ApplicationController
  def index
    @notifications = current_user.passive_notifications.includes(:visitor, :recruit).sorted.valid.page(params[:page])
    # 未読通知を既読に更新
    current_user.notification_checked
  end

  def destroy
    @notification = Notification.find(params[:id])
    @notification.destroy
  end
end
