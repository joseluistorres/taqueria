json.extract! taco, :id, :name, :spicy, :double_tortilla, :meat, :created_at, :updated_at
json.url taco_url(taco, format: :json)
