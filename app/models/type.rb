# == Schema Information
#
# Table name: types
#
#  id         :integer          not null, primary key
#  kind       :string
#  seat       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  price      :integer
#

class Type < ApplicationRecord
    has_many :tickets
    
    validates :kind, presence: true #この行を追加しました(2019/1/22)
    validates :seat, numericality: { greater_than_or_equal_to: 0 } #この行を追加しました(2019/1/22)
    validates :price, numericality: { greater_than_or_equal_to: 0 }  #この行を追加しました(2019/1/22)

  before_destroy :validate_ticket_presence

  private

  def validate_ticket_presence
    return true if tickets.blank?

    errors.add :base, '紐づくチケットが残っているため、削除できません'
    throw(:abort)
  end
end
