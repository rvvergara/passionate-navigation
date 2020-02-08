# frozen_string_literal: true

class V1::CoursesController < ApplicationController
  def index
    courses = Course.order_created

    render :index, locals: { courses: courses }, status: :ok
  end

  def show
    course = find_course
    return unless course

    render :show, locals: { course: course }, status: :ok
  end

  def create
    course = Course.new(course_params)

    if course.save
      render :create, locals: { course: course }, status: :created
    else
      process_error(course, "Cannot create course")
    end
  end

  def update; end

  def destroy; end

  private

  def find_course
    course = Course.find_by(id: params[:id])
    find_error("course") unless course
    course
  end

  def course_params
    params
      .require(:course)
      .permit(
        :name,
        :author,
        :category_id,
        :state
      )
  end
end
