class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:top]
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :unread_exist_notification, if: proc { user_signed_in? }

  def after_sign_in_path_for(resource)
    profile_user_path(current_user.nickname)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :email])
  end

  def unread_exist_notification
    notifications = current_user.passive_notifications.unread
    if notifications.blank?
      @unread = false
    end
  end
end
