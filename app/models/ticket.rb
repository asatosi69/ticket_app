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
end
