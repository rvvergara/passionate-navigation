# frozen_string_literal: true

json.count verticals.count
json.data verticals do |vertical|
  json.partial! 'v1/partials/vertical', vertical: vertical
end
