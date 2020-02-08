# frozen_string_literal: true

json.count categories.count
json.data categories do |category|
  json.partial! "v1/partials/category", category: category
end
