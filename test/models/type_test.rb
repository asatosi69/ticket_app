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

require 'test_helper'

class TypeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
