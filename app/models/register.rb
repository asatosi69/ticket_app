class Register < ApplicationRecord
  belongs_to :user
  belongs_to :ticket, optional: true
  enum state: { init: 0, confirmed: 10 }

  def generate_ticket
    ticket = Ticket.create(
      user_id: user_id,
      stage_id: stage_id,
      type_id: type_id,
      count: count,
      b_name: b_name,
      b_mail: b_email,
      comment: comment
    )
    self.ticket = ticket
    confirmed!
    UserMailer.ticket_issued(ticket).deliver_now
  end
end
