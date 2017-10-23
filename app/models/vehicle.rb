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
  has_many :tyres
end
