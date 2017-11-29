# == Schema Information
#
# Table name: tyres
#
#  id             :integer          not null, primary key
#  brand          :string
#  serial         :text
#  start_distance :decimal(, )
#  total_distance :decimal(, )
#  status         :string
#  vehicle_id     :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Tyre < ApplicationRecord
  belongs_to :vehicle, optional: true
  validates :serial, :presence => true, :uniqueness => true
  validates :brand, :presence => true

  def self.isEmpty(id)
    if self.where(vehicle_id: id).nil?.!
      @project = Vehicle.find(id)
      return @project.plate
    else
      return "null"
    end
  end

  def self.getAverage
    ret_ary = Array.new
    self.all.where(status:"destroyed").group_by(&:brand).each do |key, array|
      average = array.sum { |array| array.total_distance }/array.length
      ret_ary.push([average,key])
    end
    ret_ary
  end
end
