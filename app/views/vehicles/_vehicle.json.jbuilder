json.extract! vehicle, :id, :plate, :imei, :created_at, :updated_at
json.url vehicle_url(vehicle, format: :json)
