class User::HomesController < ApplicationController
  def top
    # ログイン中はトップページにアクセスできないように制限
    if user_signed_in?
      redirect_to profile_user_path(current_user.nickname)
    end
  end

  def home
    @recruits = Recruit.includes(:user, :entry_conditions, :play_forms)
    @recruits = @recruits.following_user_recruit(current_user).sorted
    @recruits = @recruits.page(params[:page])
  end

  def setting
  end

  def help
  end

  def contact
    @contact = Contact.new
  end

  def send_mail
    @contact = current_user.contacts.new(contact_params)
    if @contact.save
      ContactMailer.send_mail(@contact).deliver
    else
      render :contact
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:subject, :message)
  end
end
