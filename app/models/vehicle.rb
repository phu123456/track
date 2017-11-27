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

class Vehicle < ApplicationRecord
  validates :plate, :presence => true, :uniqueness => true
  validates :imei, :presence => true, :uniqueness => true

  has_many :tyres
end
