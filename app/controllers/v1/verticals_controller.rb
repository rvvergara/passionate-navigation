# frozen_string_literal: true

class V1::VerticalsController < ApplicationController
  before_action :pundit_user

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
      process_error(vertical, "Cannot create vertical")
    end
  end

  def update
    vertical = find_vertical
    return unless vertical

    if vertical.update(vertical_params)
      render :update, locals: { vertical: vertical }, status: :accepted
    else
      process_error(vertical, "Cannot update vertical")
    end
  end

  def destroy
    vertical = find_vertical
    return unless vertical

    vertical&.destroy
    action_success("Vertical deleted successfully")
  end

  private

  def find_vertical
    vertical = Vertical.find_by(id: params[:id])
    find_error("vertical") unless vertical
    vertical
  end

  def vertical_params
    params.require(:vertical).permit(:name)
  end
end
