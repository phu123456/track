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

class Position < ApplicationRecord

  def self.getPositions()
    len = Vehicle.all.size
    allVehiclePos = Array.new
    for i in 1..len
      id = Vehicle.all.find(i).id
      plate = Vehicle.all.find(i).plate
      imei = Vehicle.all.find(i).imei
      position = self.all.where(imei: imei).last
      ary = Array.new
      ary.push(id, plate, position.latitude, position.longitude)
      allVehiclePos.push(ary)
    end
    return allVehiclePos
  end
  
end
