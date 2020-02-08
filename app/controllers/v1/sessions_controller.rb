# frozen_string_literal: true

class V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user &.valid_password?(params[:password])
      data = shown_attributes(user)
      token = JsonWebToken.encode(data)
      render :create, locals: { user: user, token: token }, status: :ok
    else
      render json: { "message": "Invalid credentials" }, status: :unauthorized
    end
  end

  private

  def shown_attributes(user)
    {
      id: user.id,
      email: user.email
    }
  end
end
