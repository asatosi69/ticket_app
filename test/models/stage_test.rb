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

require 'test_helper'

class StageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
