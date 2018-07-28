json.extract! user, :id, :name, :service, :email, :country, :price, :created_at, :updated_at
json.url user_url(user, format: :json)
