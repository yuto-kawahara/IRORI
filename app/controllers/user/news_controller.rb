class User::NewsController < ApplicationController
  def index
    require 'news-api'
    news = News.new(ENV['NEWS_API_KEY'])
    board_game = "%E3%83%9C%E3%83%BC%E3%83%89%E3%82%B2%E3%83%BC%E3%83%A0, "
    murder_mystery = "%E3%83%9E%E3%83%BC%E3%83%80%E3%83%BC%E3%83%9F%E3%82%B9%E3%83%86%E3%83%AA%E3%83%BC"
    @news = news.get_everything(q: (board_game OR murder_mystery),
                                sortBy: 'relevancy',
                                pageSize: 5)
    binding.pry
  end
  def show
    binding.pry
  end
end
