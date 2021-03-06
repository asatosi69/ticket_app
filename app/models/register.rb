class Register < ApplicationRecord
  belongs_to :user
  belongs_to :ticket, optional: true
  belongs_to :stage
  belongs_to :type
  belongs_to :payment_method, optional: true
  enum state: { init: 0, confirmed: 10 }

  validates :stage_id, presence: true
  validates :type_id, presence: true
  validates :count, numericality: { greater_than: 0 }
  validates :b_name, presence: true
  validates :furigana, presence: true

  validate :check_furigana_is_zenkaku_kana

  validate :not_over_remain_count_of_seat

  validate :check_conbitation_of_type_and_stage, unless: -> { validation_context == :admin }
  def generate_ticket
    ticket = Ticket.create(
      user_id: user_id,
      stage_id: stage_id,
      type_id: type_id,
      payment_method: PaymentMethod.find_by(name: Rails.application.config.default_payment_method_name),
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

  def check_furigana_is_zenkaku_kana
    errors.add(:furigana, 'は、全角カタカナで入力してください。') if furigana !~ /\A[ァ-ヶー－]+\z/
  end
end
