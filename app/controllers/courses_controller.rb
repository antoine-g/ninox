class CoursesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  
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
    @course = Course.create(course_params)
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
    if @course.update(course_params)
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

  private
    def course_params
      params.require(:course).permit(:code, :name)
    end

end
