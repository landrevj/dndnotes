json.extract! campaign, :id, :name, :description, :content, :created_at, :updated_at
json.url campaign_url(campaign, format: :json)
