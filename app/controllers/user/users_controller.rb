class User::UsersController < ApplicationController
  before_action :ensure_correct_user
  before_action :quit_user_exclusion, except: [:withdraw, :search]

  def show
    @recruits = @user.recruits.includes(:play_forms)
    @recruits = @recruits.updated.page(params[:page])
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to profile_user_path(@user)
    else
      flash[:alert] = "ニックネームを入力してください"
      redirect_to profile_edit_user_path(params[:nickname])
    end
  end

  def unsubscribe
  end

  def withdraw
    # 一般ユーザー退会時
    if !current_user.guest_user?
      current_user.logical_delete!
    else
      # ゲストユーザー退会時は初期化処理のみ実施
      current_user.reset_guest
    end
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
    recruits = current_user.recruits.to_a
    reserves = current_user.reserves.includes(:recruit).map do |reserve|
      # 退会したユーザーの募集は表示しない
      reserve.recruit unless reserve.user.quit_user?
    end.compact
    @schedule = recruits + reserves
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
    # 退会したユーザーのページにアクセスできないように制限
    if @user.user_status == "quit_user"
      redirect_to profile_user_path(current_user)
    end
  end
end
