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
  belongs_to :vehicle
end
