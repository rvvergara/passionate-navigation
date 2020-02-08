# frozen_string_literal: true

class V1::VerticalsController < ApplicationController
  def index
    verticals = Vertical.order_created

    render :index, locals: { verticals: verticals }, status: :ok
  end

  def show; end

  def create; end

  def update; end

  def destroy; end
end
