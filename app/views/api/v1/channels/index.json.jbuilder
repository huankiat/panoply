json.channels do |json|
  json.array!(@channels) do |json, channel|
    json.extract! channel, :id, :description, :spreadsheet_id, :owner_id, :assignee_id
  end
end