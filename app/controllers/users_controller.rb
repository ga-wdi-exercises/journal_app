class UsersController < ApplicationController
  before_action :authenticate, only: [:edit, :update, :destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to users_path
    end
  end

  def update
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to users_path
    else
      if @user.update(user_params)
        redirect_to users_path
      else
        render :edit
      end
    end
  end

  def destroy
    user = User.find(params[:id])
    if user == current_user
      user.destroy
    end
    redirect_to users_path
  end

  private
  def user_params
    params.require(:user).permit(:username, :first_name, :last_name, :password, :password_confirmation)
  end
end
