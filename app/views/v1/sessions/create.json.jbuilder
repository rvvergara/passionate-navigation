# frozen_string_literal: true

json.data do
  json.partial! "v1/partials/user", user: user
end
json.token token
