# == Schema Information
#
# Table name: positions
#
#  id         :integer          not null, primary key
#  latitude   :float
#  longitude  :float
#  speed      :integer
#  imei       :text
#  period     :date
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class PositionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
