json.extract! campaign, :id, :name, :about, :created_at, :updated_at
json.url campaign_url(campaign, format: :json)
