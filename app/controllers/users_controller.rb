class UsersController < ApplicationController
  def index
    @title = "List of users"
  end

  def show
    @user  = User.find(params[:id])
    @title = @user.email
  end

  def new
    @user  = User.new
    @title = "Sign up"
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      # TODO signin
      flash[:success] = "Welcome to Ninox!"
      redirect_to user_path(@user)
    else
      @title = "Sign up"
      render 'new'
    end
  end

  def edit
    @user  = User.find(params[:id])
    @title = "Edit profile"
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      @title = "Edit Profile"
      render 'edit'
    end
    # TODO reserve to admin and self update
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to users_path
    # TODO : reserved to admin and self deletion
  end
end
