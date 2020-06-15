  json.extract! user, :id, :name, :email, :uid, :imageurl
json.url user_url(user, format: :json)
