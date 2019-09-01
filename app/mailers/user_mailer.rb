class UserMailer < ApplicationMailer
  def ticket_issued(ticket)
    return if ticket.b_mail.blank?
    @ticket = ticket
    mail(
      to: @ticket.b_mail,
      subject: 'チケットのお申し込みありがとうございました。'
    )
  end

  def notice_mail_for_create_ticket(ticket)
    return if ticket.b_mail.blank?
    @ticket = ticket
    mail(
      to: @ticket.b_mail,
      subject: 'チケットが登録されました。'
    )
  end

  def notice_mail_for_update_ticket(ticket)
    return if ticket.b_mail.blank?
    @ticket = ticket
    mail(
      to: @ticket.b_mail,
      subject: 'チケットが更新されました。'
    )
  end

  def notice_mail_for_destroy_ticket(ticket)
    return if ticket.b_mail.blank?
    @ticket = ticket
    mail(
      to: @ticket.b_mail,
      subject: 'チケットが削除されました。'
    )
  end
end
