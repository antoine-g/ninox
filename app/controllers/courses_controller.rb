class CoursesController < ApplicationController
  def index
    @title = "List of courses"
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
      redirect_to courses_path
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
    if @user.update_attributes(params[:user])
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
