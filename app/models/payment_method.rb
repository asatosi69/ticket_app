class PaymentMethod < ApplicationRecord
  validates :nickname, length: { minimum: 1, maximum: 3 }
  validates :nickname, format: { with: /\A[ぁ-んァ-ン一-龥]/, message: '全角ひらがな・カタカナ・漢字のみで入力してください' }
  validates :discount_rate, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates :name, presence: true, uniqueness: true
end
