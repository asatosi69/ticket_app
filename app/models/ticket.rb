class Ticket < ApplicationRecord
  belongs_to :user
  accepts_nested_attributes_for :user
  belongs_to :stage
  accepts_nested_attributes_for :stage
  belongs_to :type
  accepts_nested_attributes_for :type
end
