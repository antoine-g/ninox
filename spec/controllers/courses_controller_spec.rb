require 'spec_helper'

describe CoursesController do
  render_views

  describe "GET 'index'" do
    before(:each) do
      @course = FactoryGirl.create(:course)

      @courses = [@course]
      26.times do
        @courses << FactoryGirl.create(:course, code: FactoryGirl.generate(:code))
      end
      @courses.sort do |a,b|
        a.code <=> b.code
      end
    end

    it "should return http success" do
      get :index
      response.should be_success
    end

    it "should have the right title" do
      get :index
      response.should have_selector("title", content: "#{@app_name} | #{@title}")
    end

    it "should have 1 element for each user" do

      get :index
      @courses[0..24].each do |course|
        response.should have_selector("a", href: course_path(course), content: course.code)
      end
    end
    
    it "should paginate courses" do
      get :index
      response.should have_selector("nav.pagination")
      response.should have_selector("a", href: "/courses?page=2", content: "2")
      response.should have_selector("a", href: "/courses?page=2", content: "Next ")
    end
  end

  describe "GET 'show'" do
    before(:each) do
      @course = FactoryGirl.create(:course)
    end

    it "should return http success" do
      get :show, id: @course
      response.should be_success
    end

    it "should have the right title" do
      get :show, id: @course
      response.should have_selector("title", content: "#{@app_name} | #{@title}")
    end

    it "should display the right course" do
      get :show, id: @course
      assigns(:course).should == @course
    end
  end

  describe "GET 'new'" do
    it "should return http success" do
      get :new
      response.should be_success
    end

    it "should have the right title" do
      get :new
      response.should have_selector("title", content: "#{@app_name} | #{@title}")
    end
  end

  describe "POST 'create'" do
    describe "with invalid params" do
      before(:each) do
        @attr = { code: "", name: "" }
      end

      it "invalid code should render template 'new'" do
        post :create, course: @attr
        response.should render_template('new')
      end

      it "should not change course count" do
        lambda do
          post :create, course: @attr
        end.should_not change(Course, :count)
      end

      it "should have the right title" do
        post :create, course: @attr
        response.should have_selector("title", content: "#{@app_name} | #{@title}")
      end
    end

    describe "with valid params" do
      before(:each) do
        @attr = { code: "ZZ99", name: "Test" }
      end

      it "should create 1 course" do
        lambda do
          post :create, course: @attr
        end.should change(Course, :count).by(1)
      end

      it "should redirect to the course page" do
        post :create, course: @attr
        response.should redirect_to(course_path(assigns(:course)))
      end
    end
  end

  describe "GET 'edit'" do
    before(:each) do
      @course = FactoryGirl.create(:course)
    end

    it "should return http success" do
      get :edit, id: @course
      response.should be_success
    end

    it "should have the right title" do
      get :edit, id: @course
      response.should have_selector("title", content: "#{@app_name} | #{@title}")
    end
  end

  describe "PUT 'update'" do
    before(:each) do
      @course = FactoryGirl.create(:course)
    end

    describe "with invalid params" do
      before(:each) do
        @attr = { code: "", name: "" }
      end

      it "should render 'edit'" do
        put :update, id: @course, course: @attr
        response.should render_template('edit')
      end

      it "should have the right title" do
        put :update, id: @course, course: @attr
        response.should have_selector("title", content: "#{@app_name} | #{@title}")
      end
    end

    describe "with valid params" do
      before(:each) do
        @attr = { code: "ZZ99", name: "Test" }
      end

      it "should alter course characteristics" do
        put :update, id: @course, course: @attr
        @course.reload
        @course.code.should == @attr[:code]
      end

      it "should redirect to the course page" do
        put :update, id: @course, course: @attr
        response.should redirect_to(course_path(@course))
      end

      it "should display a flash message" do
        put :update, id: @course, course: @attr
        flash[:success].should =~ /Course updated/
      end
    end
  end

  describe "DELETE 'destroy'" do
    before(:each) do
      @course = FactoryGirl.create(:course)
    end

    it "should destroy 1 course" do
      lambda do
        delete :destroy, id: @course
      end.should change(Course, :count).by(-1)
    end

    it "should redirect to courses index" do
      delete :destroy, id: @course
      response.should redirect_to(courses_path)
    end

    it "should display a flash message'" do
      delete :destroy, id: @course
      flash[:success].should =~ /Course deleted/i
    end
  end
end
