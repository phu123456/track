<<<<<<< HEAD
json.extract! history, :id, :category, :created_at, :updated_at
=======
json.extract! history, :id, :category, :vehicle, :before_value, :after_value, :email, :attribute_name, :created_at, :updated_at
>>>>>>> history
json.url history_url(history, format: :json)
