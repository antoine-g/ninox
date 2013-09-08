class CoursesController < ApplicationController
  def index
    @title = "List of courses"
    @courses = Course.order(:code).page(params[:page])
  end

  def show
    @course = Course.find(params[:id])
    @title  = @course.code
  end

  def new
    @course = Course.new
    @title  = "New course"
  end

  def create
    @course = Course.new(params[:course])
    if @course.save
      flash[:success] = "Course created"
      redirect_to course_path(@course)
    else
      @title = "New course"
      render 'new'
    end
  end

  def edit
    @course = Course.find(params[:id])
    @title  = "Edit course #{@course.code}"
  end

  def update
    @course = Course.find(params[:id])
    if @course.update_attributes(params[:course])
      flash[:success] = "Course updated"
      redirect_to @course
    else
      @title = "Edit course #{@course.code}"
      render 'edit'
    end
  end

  def destroy
    Course.find(params[:id]).destroy
    flash[:success] = "Course deleted"
    redirect_to courses_path
  end
end
