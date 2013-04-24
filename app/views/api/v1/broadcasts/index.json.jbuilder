json.broadcasts do |json|
  json.array!(@broadcasts) do |json, broadcast|
    json.extract! broadcast, :id, :description

    json.channels do |json|
      json.array!(broadcast.channels) do |json, channel|
        json.extract! channel, :id, :description, :owner_id, :assignee_id
      end
    end
  end
end