class Maintenance < ApplicationRecord
  belongs_to :vehicle

  def self.percentage(id)
    # maintenance = Maintenance.find(id)
    numer = Maintenance.find(id).current_distance - Maintenance.find(id).start_distance + Maintenance.find(id).manually_distance
    denom = Service.find(Maintenance.find(id).service_id).distance_due
    puts numer
    puts denom
    return (numer.to_f/denom.to_f * 100).round(0)
  end

  def self.getStatus(id)
    status = percentage(id)
    if status < 50
      return "bg-success"
    elsif status < 75
      return "bg-warning"
    else return "bg-danger"
    end
  end

  def percentage(id)
    # maintenance = Maintenance.find(id)
    numer = Maintenance.find(id).current_distance - Maintenance.find(id).start_distance + Maintenance.find(id).manually_distance
    denom = Service.find(Maintenance.find(id).service_id).distance_due
    puts numer
    puts denom
    return (numer.to_f/denom.to_f * 100).round(0)
  end

  def getStatus(id)
    status = percentage(id)
    if status < 50
      return "bg-success"
    elsif status < 75
      return "bg-warning"
    else return "bg-danger"
    end
  end
end
