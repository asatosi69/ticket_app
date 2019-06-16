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

  private

  def validate_ticket_presence
    errors.add :base, '紐づくチケットが残っているため、削除できません'
    throw(:abort) if tickets.blank?
  end
end
