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

require 'test_helper'

class TicketTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
