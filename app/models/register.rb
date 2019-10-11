class Register < ApplicationRecord
  belongs_to :user
  belongs_to :ticket, optional: true
  belongs_to :stage
  belongs_to :type
  enum state: { init: 0, confirmed: 10 }

  validate :not_over_remain_count_of_seat

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

  private

  def not_over_remain_count_of_seat
    return if stage.remain_count_of_seat >= type.seat * count
    errors.add(:count, ': 残りの座席数を超えるため予約できません')
  end
end
