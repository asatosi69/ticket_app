class UserMailer < ApplicationMailer
  def ticket_issued(ticket)
    @ticket = ticket
    mail(
      to: @ticket.b_mail,
      subject: 'チケットのお申し込みありがとうございました。'
    )
  end
end
