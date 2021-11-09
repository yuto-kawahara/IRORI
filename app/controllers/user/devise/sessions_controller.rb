# frozen_string_literal: true

class User::Devise::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :valid_for_authenitication, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  def valid_for_authenitication
    @user = User.find_by(email: params[:user][:email])
    return if !@user
    if (@user.valid_password?(params[:user][:password])) && (@user.user_status == "quit_user")
      reset_session
      flash[:alert] = "このアカウントは退会済みです。新規登録をお願いいたします"
      redirect_to new_user_registration_path
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
