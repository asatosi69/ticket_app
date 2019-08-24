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

  validates :user_id, presence: true #この行を追加しました(2019/1/22)
  validates :stage_id, presence: true #この行を追加しました(2019/1/22)
  validates :type_id, presence: true #この行を追加しました(2019/1/22)
  validates :count, numericality: { greater_than_or_equal_to: 0 } #この行を追加しました(2019/1/22)
  validates :b_name, presence: true #この行を追加しました(2019/1/22)

  after_create :notice_mail_for_create_ticket

  def self.sumup_all_ticket_price
    joins(:type).pluck(:price).sum
  end

  def self.calc_summary_for_all
    summary = []
    User.all.each do |u|
      summary << calc_summary_for_user(u)
    end
    summary
  end

  def self.calc_summary_for_user(user)
    summary = {}
    summary[:user_id] = user.id
    summary[:user_name] = user.name
    counts_by_stage = []
    summary_total_seats = 0
    summary_counts_by_type = {}
    Stage.performance_order.each do |s|
      count_by_stage = calc_summary_for_stage_and_user(stage: s, user: user)
      counts_by_stage << count_by_stage
      count_by_stage[:counts_by_type].each do |v|
        summary_counts_by_type[:"#{v[:type_id]}"] ||= {
          type_name: v[:type_name],
          count: 0
        }
        summary_counts_by_type[:"#{v[:type_id]}"][:count] += v[:count]
        summary_counts_by_type[:"#{v[:type_id]}"][:color_code] ||= v[:color_code]
      end
      summary_total_seats += count_by_stage[:total_seats_count]

    end
    summary[:total_counts] = {
      summary_total_seats: summary_total_seats
    }
    summary[:counts_by_stage] = counts_by_stage
    summary[:summary_counts_by_type] = summary_counts_by_type
    summary
  end

  def self.calc_summary_for_stage_and_user(stage: nil, user: nil)
    tickets = Ticket.where(stage_id: stage.id, user_id: user.id)
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
      sum + ticket.type.seat
    end
    {
      stage_id: stage.id,
      stage_performance: stage.performance,
      total_seats_count: total_seats_count,
      counts_by_type: counts_by_type
    }
  end
  private_class_method :calc_summary_for_stage_and_user

  private

  def notice_mail_for_create_ticket
    UserMailer.notice_mail_for_create_ticket(self).deliver_now
  end
end
