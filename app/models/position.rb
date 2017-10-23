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
end
