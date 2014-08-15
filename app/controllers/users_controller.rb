class UsersController < ApplicationController
  def index
    @title = "List of users"
    @users = User.order(:email).page(params[:page])
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
    if (@user != current_user)
      redirect_to root_path, alert: "Access denied"
    end
    @title = "Edit profile"
  end

  def update
    @user = User.find(params[:id])
    if (@user != current_user)
      redirect_to root_path, alert: "Forbidden operation"
    end
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
    @user = User.find(params[:id])
    if (@user != current_user)
      redirect_to root_path, alert: "Forbidden operation"
    end
    @user.destroy
    flash[:success] = "Profile deleted"
    redirect_to users_path
    # TODO : reserved to admin and self deletion
  end
end
