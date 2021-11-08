class ContactMailer < ApplicationMailer
  default from: 'noreply@example.com'
  default to: 'admin@example.com'
  layout 'mailer'

  def send_mail(contact)
    @contact = contact
    mail from: @contact.user.email, to: ENV['ADMIN_EMAIL'], subject: @contact.subject
  end
end
