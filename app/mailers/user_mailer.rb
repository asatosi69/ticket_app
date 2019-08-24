class UserMailer < ApplicationMailer
  def ticket_issued(ticket)
    @ticket = ticket
    mail(
      to: @ticket.b_mail,
      subject: 'チケットのお申し込みありがとうございました。'
    )
  end

  def notice_mail_for_create_ticket(ticket)
    @ticket = ticket
    mail(
      to: @ticket.user.email,
      subject: 'チケットが登録されました。'
    )
  end

  def notice_mail_for_update_ticket(ticket)
    @ticket = ticket
    mail(
      to: @ticket.user.email,
      subject: 'チケットが更新されました。'
    )
  end
end
