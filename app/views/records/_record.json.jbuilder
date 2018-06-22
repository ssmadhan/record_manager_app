json.extract! record, :id, :title, :artist, :year, :condition, :created_at, :updated_at
json.url record_url(record, format: :json)
