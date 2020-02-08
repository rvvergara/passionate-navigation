# frozen_string_literal: true

class ApplicationController < ActionController::API
  def find_error(resource_type)
    render json: { message: "Cannot find #{resource_type}" }, status: 404
  end

  def process_error(resource, message)
    render json: { message: message, errors: resource.errors }, status: :unprocessable_entity
  end

  def action_success(message, status_code = nil)
    status_code ||= :accepted
    render json: { message: message },
           status: status_code
  end
end
