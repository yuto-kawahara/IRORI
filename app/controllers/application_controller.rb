class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:top]
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :unread_exist_notification, if: proc { user_signed_in? }
  before_action :get_news_index, except: [:top]

  def after_sign_in_path_for(resource)
    profile_user_path(current_user.nickname)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :email])
  end

  def unread_exist_notification
    notifications = current_user.passive_notifications.unread
    notifications = notifications.valid
    if notifications.blank?
      @unread = false
    end
  end

  def get_news_index
    require 'news-api'
    news = News.new(ENV['NEWS_API_KEY'])
    board_game = "%E3%83%9C%E3%83%BC%E3%83%89%E3%82%B2%E3%83%BC%E3%83%A0, "
    murder_mystery = "%E3%83%9E%E3%83%BC%E3%83%80%E3%83%BC%E3%83%9F%E3%82%B9%E3%83%86%E3%83%AA%E3%83%BC"
    @news = news.get_everything(q: (board_game or murder_mystery),
                                sortBy: 'relevancy',
                                pageSize: 5)

  end

end
