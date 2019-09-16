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

  def calc_adequacy_ratio
    (sumup_ticket_seat.to_f / total.to_f) * 100
  end

  def sumup_ticket_price
    tickets.joins(:type).pluck(:count, :price).map { |count, price| count * price }.sum
  end

  def sumup_ticket_seat
    tickets.inject(0) { |sum, ticket| sum += ticket.type.seat * ticket.count}
  end

  private

  def validate_ticket_presence
    return true if tickets.blank?

    errors.add :base, 'このレコードを用いてチケットの申込が実施されています。削除する場合は申込済のチケットの情報を変更してください。'
    throw(:abort)
  end
end
