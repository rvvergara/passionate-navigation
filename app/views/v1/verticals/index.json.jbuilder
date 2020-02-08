# frozen_string_literal: true

json.count verticals.count
json.data verticals do |vertical|
  json.id vertical.id
  json.name vertical.name
end
