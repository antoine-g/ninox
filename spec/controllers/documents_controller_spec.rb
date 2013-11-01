require 'spec_helper'

describe DocumentsController do
  render_views
  before(:each) do
    @attr = { title: "Doc title", desc: "Description of the document",
              docfile: fixture_file_upload('/testdoc.txt', 'text/txt'),
              user_id: FactoryGirl.create(:user)}
    @document = FactoryGirl.create(:document)
  end

  describe "GET 'index'" do
    before(:each) do
      @documents = [@document]
      25.times do
        @documents << FactoryGirl.create(:document)
      end
    end

    it "should return http success" do
      get 'index'
      response.should be_success
    end

    it "should have the right title" do
      get :index
      response.should have_selector("title", content: "#{@app_name} | #{@title}")
    end

    it "should have 1 element for each document" do
      get :index
      @documents.each do |document|
        response.should have_selector("td", content: document.title)
      end
    end
    
    it "should paginate documents" do
      get :index
      response.should have_selector("nav.pagination")
      response.should have_selector("a", href: "/documents?page=2", content: "2")
      response.should have_selector("a", href: "/documents?page=2", content: "Next ")
    end
  end

  describe "GET 'show'" do
    it "should return http success" do
      get 'show', id: @document.id
      response.should be_success
    end

    it "should have the right title" do
      get 'show', id: @document.id
      response.should have_selector("title", content: "#{@app_name} | #{@title}")
    end

    it "should display the right document" do
      get :show, id: @document.id
      assigns(:document).should == @document
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
    it "should create 1 document" do
      lambda do
        post :create, document: @attr
      end.should change(Document, :count).by(1)
    end

    it "should redirect to the document page" do
      post :create, document: @attr
      response.should redirect_to(document_path(assigns[:document]))
    end
  end

  describe "GET 'edit'" do
    it "should return http success" do
      get :edit, id: @document.id
      response.should be_success
    end

    it "should have the right title" do
      get :edit, id: @document.id
      response.should have_selector("title", content: "#{@app_name} | #{@title}")
    end
  end

  describe "PUT 'update'" do
    it "should alter document characteristics" do
      put :update, id: @document.id, document: @attr
      @document.reload
      @document.title.should == @attr[:title]
    end

    it "should redirect to the document page" do
      put :update, id: @document.id, document: @attr
      response.should redirect_to(document_path(@document))
    end

    it "should display a flash message" do
      put :update, id: @document.id, document: @attr
      flash[:success].should =~ /Document updated/
    end
  end

  describe "DELETE 'destroy'" do
    it "should destroy 1 document" do
      lambda do
        delete :destroy, id: @document.id
      end.should change(Document, :count).by(-1)
    end

    it "should redirect to documents index" do
      delete :destroy, id: @document.id
      response.should redirect_to(documents_path)
    end

    it "should display a flash message'" do
      delete :destroy, id: @document.id
      flash[:success].should =~ /Document deleted/i
    end
  end
end
