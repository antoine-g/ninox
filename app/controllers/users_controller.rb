class UsersController < ApplicationController
  def index
    @title = "List of users"
  end

  def show
    @user  = User.find(params[:id])
    @title = User.email
  end

  def new
    @user  = User.new
    @title = "Signup"
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      # TODO signin
      flash[:success] = "Bienvenue dans l'Application Exemple!"
      redirect_to user_path(@user)
    else
      @titre = "Inscription"
      render 'new'
    end
  end

  def edit
    @user  = User.find(params[:id])
    @title = "Edit profile"
  end

  def update
    @user  = User.find(params[:id])
    @title = "TODO"
    # TODO reserve to admin and self update
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to users_path
    # TODO : reserved to admin and self deletion
  end
end
