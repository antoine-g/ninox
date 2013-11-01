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
      get 'show', id: @user
      response.should be_success
    end

    it "should have the right title" do
      get 'show', id: @user
      response.should have_selector("title", content: "#{@app_name} | #{@user.email}")
    end

    it "should display the right user" do
      get :show, id: @user
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
      response.should have_selector("title", content: "#{@app_name} | #{@title}")
    end
  end

  describe "POST 'create'" do

    describe "with invalid params" do
      before(:each) do
        @attr = { email: "", password: "", password_confirmation: "" }
      end

      it "invalid email should render template 'new'" do
        post :create, user: @attr
        response.should render_template('new')
      end

      it "should not change user count" do
        lambda do
          post :create, user: @attr
        end.should_not change(User, :count)
      end

      it "should have the right title" do
        post :create, user: @attr
        response.should have_selector("title", content: "#{@app_name} | #{@title}")
      end
    end

    describe "with valid params" do
      before(:each) do
        @attr = { email: "user@example.com", password: "foobar", password_confirmation: "foobar" }
      end

      it "should create 1 user" do
        lambda do
          post :create, user: @attr
        end.should change(User, :count).by(1)
      end

      it "should redirect to the user page" do
        post :create, user: @attr
        response.should redirect_to(user_path(assigns(:user)))
      end
      
      it "should display a welcome message" do
        post :create, user: @attr
        flash[:success].should =~ /Welcome to Ninox!/i
      end
    end
  end

  describe "GET 'edit'" do
    before(:each) do
      @user = FactoryGirl.create(:user)
    end

    it "should return http success" do
      get :edit, id: @user
      response.should be_success
    end

    it "should have the right title" do
      get :edit, id: @user
      response.should have_selector("title", content: "#{@app_name} | #{@title}")
    end
  end

  describe "PUT 'update'" do
    before(:each) do
      @user = FactoryGirl.create(:user)
    end

    describe "with invalid params" do
      before(:each) do
        @attr = { email: "", password: "", password_confirmation: "" }
      end

      it "should render 'edit'" do
        put :update, id: @user, user: @attr
        response.should render_template('edit')
      end

      it "should have the right title" do
        put :update, id: @user, user: @attr
        response.should have_selector("title", content: "#{@app_name} | #{@title}")
      end
    end

    describe "with valid params" do
      before(:each) do
        @attr = { email: "user@example.org", password: "newpassword", password_confirmation: "newpassword" }
      end

      it "should alter user characteristics" do
        put :update, id: @user, user: @attr
        @user.reload
        @user.email.should == @attr[:email]
      end

      it "should redirect to the user page" do
        put :update, id: @user, user: @attr
        response.should redirect_to(user_path(@user))
      end

      it "should display a flash message" do
        put :update, id: @user, user: @attr
        flash[:success].should =~ /Profile updated/
      end
    end
  end

  describe "DELETE 'destroy'" do
    before(:each) do
      @user = FactoryGirl.create(:user)
    end

    it "should destroy 1 user" do
      lambda do
        delete :destroy, id: @user
      end.should change(User, :count).by(-1)
    end

    it "should redirect to users index" do
      delete :destroy, id: @user
      response.should redirect_to(users_path)
    end

    it "should display a flash message'" do
      delete :destroy, id: @user
      flash[:success].should =~ /Profile deleted/i
    end
  end

  describe "GET 'index'" do
    before(:each) do
      @users = []
      26.times do
        @users << FactoryGirl.create(:user, email: FactoryGirl.generate(:email))
      end
      @users.sort do |a,b|
        a.email <=> b.email
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
      @users[0..24].each do |user|
        response.should have_selector("a", href: user_path(user), content: user.email)
      end
    end
    
    it "should paginate users" do
      get :index
      response.should have_selector("nav.pagination")
      response.should have_selector("a", href: "/users?page=2", content: "2")
      response.should have_selector("a", href: "/users?page=2", content: "Next ")
    end
  end
end
