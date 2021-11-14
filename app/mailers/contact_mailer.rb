class ContactMailer < ApplicationMailer
  default to: 'admin@example.com'
  layout 'mailer'

  def send_mail(contact)
    @contact = contact
    mail from: "問い合わせ通知<#{@contact.user.email}>", to: ENV['ADMIN_EMAIL'], subject: @contact.subject
  end
end
