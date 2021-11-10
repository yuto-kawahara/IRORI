class User::UsersController < ApplicationController
  before_action :ensure_correct_user
  before_action :quit_user_exclusion, except: [:withdraw, :search]

  def show
    @recruits = @user.recruits.sorted.page(params[:page])
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to profile_user_path(@user)
    else
      render :edit
    end
  end

  def unsubscribe
  end

  def withdraw
    delete_flg = "_quited_user_" + I18n.l(Time.current, format: :long)
    deleted_name = current_user.nickname + delete_flg
    deleted_email = current_user.email + delete_flg
    current_user.assign_attributes(nickname: deleted_name,
                                   email: deleted_email,
                                   user_status: "quit_user")
    current_user.skip_email_changed_notification!
    current_user.save!
    reset_session
    redirect_to root_path
  end

  def followings
    @users = @user.following_user.valid.sorted.page(params[:page])
  end

  def followers
    @users = @user.follower_user.valid.sorted.page(params[:page])
  end

  def reserve
    @reserves = current_user.reserves.page(params[:page])
  end

  def schedule
    @recruits = current_user.recruits
    @other_recruits = Recruit.where.not(user_id: current_user.id)
    @other_recruits.each do |recruit|
      reserve = recruit.reserves.find_by(user_id: current_user.id)
      unless reserve.blank?
        @recruits.push(reserve.recruit)
      end
    end
  end

  def search
    @users = User.valid.not_current(current_user)
    @users = @users.where('nickname LIKE(?)', "%#{params[:keyword]}%")
    respond_to do |format|
      format.html
      format.json
    end
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :introduction, :icon_image)
  end

  def ensure_correct_user
    @user = User.find_by(nickname: params[:nickname])
    if @user == current_user
      @user = current_user
    end
  end

  def quit_user_exclusion
    if @user.user_status == "quit_user"
      redirect_to profile_user_path(current_user)
    end
  end
end
