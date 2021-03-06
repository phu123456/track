# == Schema Information
#
# Table name: positions
#
#  id             :integer          not null, primary key
#  latitude       :float
#  longitude      :float
#  speed          :integer
#  imei           :text
#  period         :date
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  totalDistance  :integer
#  isCalculate_id :integer
#

class Position < ApplicationRecord

  def self.getAddress(vehicle_id)
    imei = Vehicle.find(vehicle_id).imei
    position = Position.all.where(imei: imei).last
    # puts "noooooo"
    # puts position
    if position.nil?
      return "unknown1"
    else
      lat = position.latitude.to_s
      lng = position.longitude.to_s
      address = Geocoder.search(lat + "," + lng)[1].try(:formatted_address)
      # puts "---yes---"
      # puts Geocoder.search(lat + "," + lng)[1].try(:formatted_address)
        if !address.nil?
          return Vehicle.find(vehicle_id).plate ,position.speed, address.split(",")
        else
          return "unknown2"
        end
    end
  end

  def self.getPositions()
    len = Vehicle.all.size
    allVehiclePos = Array.new
    for i in 0..len-1
      id = Vehicle.all[i].id
      plate = Vehicle.all[i].plate
      imei = Vehicle.all[i].imei
      position = Position.all.where(imei: imei).last
      # puts position
      ary = Array.new
      if position.nil?
      else
        ary.push(id, plate, position.latitude, position.longitude, position.speed)
        allVehiclePos.push(ary)
      end
    end
    return allVehiclePos
  end

  def self.getPath(vehicle_id, start_date, end_date)

    imei = Vehicle.all.where(id: vehicle_id)[0].imei

    positions = Position.all.where("created_at BETWEEN ? AND ?", start_date, end_date).where(imei: imei).where("speed != ?", 0.0)
    speed, date, len, graph= positions.pluck(:speed), positions.pluck(:created_at), positions.all.size, Array.new
    coordinateAry = Array.new
    distanceAry = Array.new

    for i in 0..len-1
      input = {"year": i,"value": speed[i]}
      graph.push(input)
    end

    for i in 0..len-1
      dict = {lat: positions[i].latitude, lng: positions[i].longitude}
      coordinateAry.push(dict)
    end

    #calculate distance between two location
    for i in 0..len-2
      start_point = coordinateAry[i][:lat], coordinateAry[i][:lng]
      end_point = coordinateAry[i+1][:lat], coordinateAry[i+1][:lng]
      distance = Geocoder::Calculations.distance_between(start_point, end_point, :units => :km)
      distanceAry.push(distance)
    end
    total_distance = distanceAry.inject(0){|sum,x| sum + x }

    return [coordinateAry, total_distance, speed]
  end

  def self.getTime(imei)
    if !Position.where(imei: imei).last.try(:created_at).nil?
      Position.where(imei: imei).last.try(:created_at).strftime("%I:%M %p")

      # Time.now
      # (Time.parse(Position.where(imei: imei).last.try(:created_at)) - Time.now) / 60

    end
  end
end
