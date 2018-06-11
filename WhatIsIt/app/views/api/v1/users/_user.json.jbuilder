json.extract! user, :id, :created_at, :updated_at, :username, :image
json.url user_url(user, format: :json)
