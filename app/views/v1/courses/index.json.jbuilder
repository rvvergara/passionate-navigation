# frozen_string_literal: true

json.count courses.count
json.data courses do |course|
  json.partial! "v1/partials/course", course: course
end
