json.channel do |json|
  json.extract! @channel, :id, :description, :value, :spreadsheet_id, :owner_id, :assignee_id
end