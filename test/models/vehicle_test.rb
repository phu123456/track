# == Schema Information
#
# Table name: vehicles
#
#  id         :integer          not null, primary key
#  plate      :text
#  imei       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  distance   :decimal(, )
#

require 'test_helper'

class VehicleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
