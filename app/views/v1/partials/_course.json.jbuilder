# frozen_string_literal: true

json.course do
  json.id course.id
  json.name course.name
  json.author course.author
  json.category do
    json.partial! "v1/partials/category_short", category: course.category
  end
end
