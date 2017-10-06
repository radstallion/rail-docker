json.extract! note, :id, :title, :desc, :created_at, :updated_at
json.url note_url(note, format: :json)
