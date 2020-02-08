# frozen_string_literal: true

class V1::UsersController < ApplicationController
  def create
    user = User.new(user_params)

    if user.save
      data = shown_attributes(user)
      token = JsonWebToken.encode(data)
      render :create, locals: { user: user, token: token }, status: :created
    else
      process_error(user, "Cannot create account")
    end
  end

  private

  def user_params
    params
      .require(:user)
      .permit(:email, :password, :password_confirmation)
  end
end
