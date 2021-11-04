class User::HomesController < ApplicationController
  def top
  end

  def home
    @recruits = Recruit.following_user_recruit(current_user).sorted
    @recruits = @recruits.includes(:user).page(params[:page])
  end

  def setting
  end

  def help
  end

  def contact
  end

end
