json.extract! service, :id, :name, :service, :email, :country, :price, :created_at, :updated_at
json.url service_url(service, format: :json)
