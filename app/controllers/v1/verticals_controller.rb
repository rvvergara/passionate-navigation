# frozen_string_literal: true

class V1::VerticalsController < ApplicationController
  def index
    verticals = Vertical.order_created

    render :index, locals: { verticals: verticals }, status: :ok
  end

  def show; end

  def create
    vertical = Vertical.new(vertical_params)

    if vertical.save
      render :create, locals: { vertical: vertical }, status: :created
    else
      process_error(vertical, 'Cannot create vertical')
    end
  end

  def update; end

  def destroy; end

  private

  def vertical_params
    params.require(:vertical).permit(:name)
  end
end
