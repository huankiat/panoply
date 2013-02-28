json.channels do |json|
  json.array!(@channels) do |json, channel|
    json.extract! channel, :id, :description
  end
end