# frozen_string_literal: true

class ApplicationController < ActionController::API
  def process_error(resource, message)
    render json: { message: message, errors: resource.errors }, status: :unprocessable_entity
  end
end
