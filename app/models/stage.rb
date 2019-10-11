# == Schema Information
#
# Table name: stages
#
#  id          :integer          not null, primary key
#  performance :string
#  total       :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  deadline    :datetime
#  end_flag    :boolean          default(FALSE)
#

class Stage < ApplicationRecord
  has_many :tickets

  validates :performance, presence: true # この行を追加しました(2019/1/22)
  validates :total, numericality: { greater_than_or_equal_to: 0 } # この行を追加しました(2019/1/22)
  validates :deadline, presence: true # この行を追加しました(2019/1/22)

  before_destroy :validate_ticket_presence

  scope :performance_order, -> { order(performance: :asc) }
  scope :within_deadline, -> { where('deadline > ?', ::Time.current) }
  scope :on_sale, -> { within_deadline.where(end_flag: false) }

  def remain_count_of_seat
    total - sumup_ticket_seat
  end

  def calc_adequacy_ratio
    (sumup_ticket_seat.to_f / total.to_f) * 100
  end

  def sumup_ticket_price
    tickets.joins(:type).pluck(:count, :price).map { |count, price| count * price }.sum
  end

  def sumup_ticket_seat
    tickets.inject(0) { |sum, ticket| sum += ticket.type.seat * ticket.count}
  end

  def end_flag
    return true if self[:end_flag]
    calc_end_flag!
  end
  alias end_flag? end_flag

  def calc_end_flag!
    return if self[:end_flag]

    if deadline.past? || calc_adequacy_ratio >= 100
      update_attribute(:end_flag, true)
      true
    else
      false
    end
  end

  def end_reason
    if end_flag?
      if calc_adequacy_ratio >= 100
        '受付予定枚数を超えたため、受付を終了しました'
      elsif deadline.past?
        '予約受付時間を過ぎたため、受付を終了しました'
      else
        '管理者が予約受付を停止致しました'
      end
    else
      '-'
    end
  end

  private

  def validate_ticket_presence
    return true if tickets.blank?

    errors.add :base, 'このレコードを用いてチケットの申込が実施されています。削除する場合は申込済のチケットの情報を変更してください。'
    throw(:abort)
  end
end
