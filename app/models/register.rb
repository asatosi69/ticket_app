class Register < ApplicationRecord
  belongs_to :user
  belongs_to :ticket, optional: true
  belongs_to :stage
  belongs_to :type
  enum state: { init: 0, confirmed: 10 }

  validates :stage_id, presence: true
  validates :type_id, presence: true
  validates :count, numericality: { greater_than: 0 }
  validates :b_name, presence: true
  validates :furigana, presence: true

  validate :not_over_remain_count_of_seat

  validate :check_conbitation_of_type_and_stage, unless: -> { validation_context == :admin }
  def generate_ticket
    ticket = Ticket.create(
      user_id: user_id,
      stage_id: stage_id,
      type_id: type_id,
      count: count,
      b_name: b_name,
      furigana: furigana,
      b_mail: b_email,
      comment: comment
    )
    self.ticket = ticket
    confirmed!
  end

  private

  def not_over_remain_count_of_seat
    return if stage.remain_count_of_seat >= type.seat * count

    errors.add(:count, ': 残りの座席数を超えるため予約できません')
  end

  def check_conbitation_of_type_and_stage
    return unless Link.find_by(stage_id: stage_id, type_id: type_id)

    errors.add(:stage_and_type, '：選択いただいた『開演日時 / チケット種別』の組み合わせでは予約を承ることができません。')
  end
end
