class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :authenticate_user, except: %i[new create]
  before_action :prevent_customer, only: :index
  before_action :prevent_admin, only: %i[show edit]

  def index
    @users = User.where(role: "customer")
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login(@user)
      flash[:notice] = "Welcome!"
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(current_user), notice: "Account updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if current_user.admin?
      @user.destroy
      flash[:notice] = "User deleted!"
      redirect_to users_path
    else
      log_out
      @user.destroy
      flash[:notice] = "Account deleted!"
      redirect_to root_path
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
