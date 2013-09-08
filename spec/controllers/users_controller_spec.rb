require 'spec_helper'

describe UsersController do
  render_views

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    before(:each) do
      @user = FactoryGirl.create(:user)
    end

    it "should return http success" do
      get 'show', :id => @user
      response.should be_success
    end

    it "should have the right title" do
      get 'show', :id => @user
      response.should have_selector(:title => "#{@app_name} | #{@user.email}")
    end

    it "should display the right user" do
      get :show, :id => @user
      assigns(:user).should == @user
    end
  end

  describe "GET 'new'" do
    it "should return http success" do
      get 'new'
      response.should be_success
    end

    it "should have the right title" do
      get 'new'
      response.should have_selector(:title => "#{@app_name} | #{@title}")
    end
  end

  describe "POST 'create'" do

    describe "with invalid params" do
      before(:each) do
        @attr = { :email => "", :password => "", :password_confirmation => "" }
      end

      it "invalid email should render template 'new'" do
        post :create, :user => @attr
        response.should render_template('new')
      end

      it "should not change user count" do
        lambda do
          post :create, :user => @attr
        end.should_not change(User, :count)
      end

      it "should have the right title" do
        post :create, :user => @attr
        response.should have_selector("title", :content => "#{@app_name} | #{@title}")
      end
    end

    describe "with valid params" do
      before(:each) do
        @attr = { :email => "user@example.com", :password => "foobar", :password_confirmation => "foobar" }
      end

      it "should create 1 user" do
        lambda do
          post :create, :user => @attr
        end.should change(User, :count).by(1)
      end

      it "should redirect to the user page" do
        post :create, :user => @attr
        response.should redirect_to(user_path(assigns(:user)))
      end
      
      it "should display a welcome message" do
        post :create, :user => @attr
        flash[:success].should =~ /Welcome to Ninox!/i
      end
    end
  end
end
