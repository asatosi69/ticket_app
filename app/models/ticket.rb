# == Schema Information
#
# Table name: tickets
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  count      :integer
#  b_name     :string
#  b_mail     :string
#  comment    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  stage_id   :integer
#  type_id    :integer
#  comment2   :text
#

class Ticket < ApplicationRecord
  belongs_to :user
  accepts_nested_attributes_for :user
  belongs_to :stage
  accepts_nested_attributes_for :stage
  belongs_to :type
  accepts_nested_attributes_for :type
  belongs_to :payment_method

  validates :user_id, presence: true #この行を追加しました(2019/1/22)
  validates :stage_id, presence: true #この行を追加しました(2019/1/22)
  validates :type_id, presence: true #この行を追加しました(2019/1/22)
  validates :payment_method_id, presence: true
  validates :count, numericality: { greater_than: 0 } #この行を追加しました(2019/1/22)
  validates :b_name, presence: true #この行を追加しました(2019/1/22)
  validates :furigana, presence: true

  after_create :notice_mail_for_create_ticket
  after_update :notice_mail_for_update_ticket
  after_destroy :notice_mail_for_destroy_ticket
  after_commit :calc_stage_end_flag

  validate :check_furigana_is_zenkaku_kana
  validate :not_over_remain_count_of_seat, unless: -> { validation_context == :admin }
  validate :check_conbitation_of_type_and_stage, unless: -> { validation_context == :admin }

  def self.sumup_all_ticket_price
    joins(:type).joins(:payment_method).pluck(:count, :price, :discount_rate).map { |count, price, discount_rate| (count * price * ((100-discount_rate)/100.to_f)).to_i}.sum
  end

  def self.calc_summary_for_all
    summary = []
    User.all.each do |u|
      summary << calc_summary_for_user(u)
    end
    summary
  end

  def self.calc_summary_for_stage(stage)
    tickets = Ticket.where(stage_id: stage.id)
    counts_by_type = []
    Type.all.each do |t|
      counts_by_type << {
        type_id: t.id,
        type_name: t.kind,
        color_code: t.color.color_code,
        count: tickets.where(type_id: t.id).pluck(:count).sum
      }
    end
    total_seats_count = tickets.inject(0) do |sum, ticket|
      sum + ticket.type.seat * ticket.count
    end
    {
      stage_id: stage.id,
      stage_performance: stage.performance,
      total_seats_count: total_seats_count,
      counts_by_type: counts_by_type
    }
  end

  SummaryForUser = Struct.new(
    :user_id,
    :user_name,
    :total_counts,
    :counts_by_stage,
    :summary_counts_by_type
  )

  SummaryForStageAndUser = Struct.new(
    :stage_id,
    :stage_performance,
    :total_seats_count,
    :counts_by_type
  )

  SummaryCountByType = Struct.new(
    :type_id,
    :type_name,
    :color_code,
    :count
  )

  def self.calc_summary_for_user(user)
    summary = SummaryForUser.new
    summary.user_id = user.id
    summary.user_name = user.name
    counts_by_stage = []
    summary_total_seats = 0
    summary_counts_by_type = {}
    Stage.performance_order.each do |s|
      count_by_stage = calc_summary_for_stage_and_user(stage: s, user: user)
      counts_by_stage << count_by_stage
      count_by_stage[:counts_by_type].each do |v|
        if summary_counts_by_type[:"#{v.type_id}"].blank?
          summary_count_by_type = SummaryCountByType.new
          summary_count_by_type.type_name = v.type_name
          summary_count_by_type.color_code = v.color_code
          summary_count_by_type.count = 0
          summary_counts_by_type[:"#{v.type_id}"] = summary_count_by_type
        end
        summary_counts_by_type[:"#{v.type_id}"].count += v.count
      end
      summary_total_seats += count_by_stage.total_seats_count
    end
    summary.total_counts = {
      summary_total_seats: summary_total_seats
    }
    summary.counts_by_stage = counts_by_stage
    summary.summary_counts_by_type = summary_counts_by_type
    summary
  end

  def self.calc_summary_for_stage_and_user(stage: nil, user: nil)
    tickets = Ticket.where(stage_id: stage.id, user_id: user.id)
    counts_by_type = []
    Type.all.each do |t|
      count_by_type = SummaryCountByType.new
      count_by_type.type_id = t.id
      count_by_type.type_name = t.kind
      count_by_type.color_code = t.color.color_code
      count_by_type.count = tickets.where(type_id: t.id).pluck(:count).sum
      counts_by_type << count_by_type
    end
    total_seats_count = tickets.inject(0) do |sum, ticket|
      sum + ticket.type.seat * ticket.count
    end
    summary_for_stage_and_user = SummaryForStageAndUser.new
    summary_for_stage_and_user.stage_id = stage.id
    summary_for_stage_and_user.stage_performance = stage.performance
    summary_for_stage_and_user.total_seats_count = total_seats_count
    summary_for_stage_and_user.counts_by_type = counts_by_type
    summary_for_stage_and_user
  end
  private_class_method :calc_summary_for_stage_and_user

  private

  def calc_stage_end_flag
    stage.calc_end_flag!
  end

  def notice_mail_for_create_ticket
    UserMailer.notice_mail_for_create_ticket(self).deliver_now
  end

  def notice_mail_for_update_ticket
    UserMailer.notice_mail_for_update_ticket(self).deliver_now
  end

  def notice_mail_for_destroy_ticket
    UserMailer.notice_mail_for_destroy_ticket(self).deliver_now
  end

  def not_over_remain_count_of_seat
    return if stage.remain_count_of_seat >= type.seat * count

    errors.add(:count, ': 残りの座席数を超えるため予約できません')
  end

  def check_conbitation_of_type_and_stage
    return unless Link.find_by(stage_id: stage_id, type_id: type_id)

    errors.add(:stage_id, '選択いただいた『開演日時 / チケット種別』の組み合わせでは予約を承ることができません。')
    errors.add(:type_id, '')
  end

  def check_furigana_is_zenkaku_kana
    return if furigana.blank?

    errors.add(:furigana, 'は、全角カタカナで入力してください。') if furigana !~ /\A[ァ-ヶー－]+\z/
  end
end
