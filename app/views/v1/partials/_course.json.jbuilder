# frozen_string_literal: true

json.course do
  json.id course.id
  json.name course.name
  json.author course.author
  json.partial! "v1/partials/category", category: course.category
end
