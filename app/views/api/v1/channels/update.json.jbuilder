json.channel do |json|
  json.extract! @channel, :id, :description, :value
end