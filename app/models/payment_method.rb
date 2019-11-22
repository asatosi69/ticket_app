class PaymentMethod < ApplicationRecord
  validates :discount_rate, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
end
