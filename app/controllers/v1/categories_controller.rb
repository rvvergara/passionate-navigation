# frozen_string_literal: true

class V1::CategoriesController < ApplicationController
  def index
    categories = Category.order_created

    render :index, locals: { categories: categories }, status: :ok
  end

  def show; end

  def create
    category = Category.new(category_params)

    if category.save
      render :create, locals: { category: category }, status: :created
    else
      process_error(category, "Cannot create category")
    end
  end

  def update
    category = find_category
    return unless category

    if category.update(category_params)
      render :update, locals: { category: category }, status: :accepted
    else
      process_error(category, "Cannot update category")
    end
  end

  def destroy
    category = find_category
    return unless category

    category&.destroy
    action_success("Category deleted successfully")
  end

  private

  def find_category
    category = Category.find_by(id: params[:id])
    find_error("category") unless category
    category
  end

  def category_params
    params
      .require(:category)
      .permit(:name, :state, :vertical_id)
  end
end
