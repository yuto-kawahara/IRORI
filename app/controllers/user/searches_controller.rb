class User::SearchesController < ApplicationController
  def user
    @content = params[:content]
    @users = User.where.not(id: current_user.id).valid.sorted
    @users = @users.where('nickname LIKE ?', "%#{@content}%").page(params[:page])

  end

  def recruit
    @content = params[:content]
    @recruits = Recruit.includes(:user, :entry_conditions, :play_forms).valid.sorted
    @recruits = @recruits.where('title LIKE ?', "%#{@content}%").page(params[:page])
  end
end
