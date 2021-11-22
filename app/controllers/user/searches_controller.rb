class User::SearchesController < ApplicationController
  def user
    @keyword = params[:keyword]
    @users = User.where.not(id: current_user.id).valid.sorted
    @users = @users.where('nickname LIKE ?', "%#{@keyword}%").page(params[:page])

  end

  def recruit
    @keyword = params[:keyword]
    @recruits = Recruit.includes(:user, :entry_conditions, :play_forms).valid.sorted
    @recruits = @recruits.where('title LIKE ?', "%#{@keyword}%").page(params[:page])
  end
end
