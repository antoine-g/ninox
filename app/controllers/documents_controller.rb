class DocumentsController < ApplicationController
  def index
    @title = "List of documents"
    @docs  = Document.order(:title).page(params[:page])
  end

  def show
    @doc   = Document.find(params[:id])
    @title = @doc.title
  end

  def new
    @doc   = Document.new
    @title = "New document"
  end

  def create
    @doc = Document.new(params[:doc])
    if @doc.save
      flash[:success] = "Document created"
      redirect_to document_path(@doc)
    else
      @title = "New document"
      render 'new'
    end
  end

  def edit
    @doc   = Document.find(params[:id])
    @title = "Edit document"
  end

  def update
    @doc = Document.find(params[:id])
    if @doc.update_attributes(params[:user])
      flash[:success] = "Document updated"
      redirect_to @doc
    else
      @title = "Edit document"
      render 'edit'
    end
  end

  def destroy
  end
end
