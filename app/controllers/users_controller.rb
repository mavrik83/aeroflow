# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  before_action :require_user, only: %i[edit update]
  before_action :require_same_user, only: %i[edit update destroy]

  def index
    if logged_in? && current_user.admin?
      @users = User.order('created_at DESC').paginate(page: params[:page], per_page: 5)
    elsif logged_in?
      redirect_to questions_path
    else
      redirect_to root_path
    end
  end

  def show
    @questions = @user.questions.order('created_at DESC').paginate(page: params[:page], per_page: 5)
    @answers = @user.answers.order('created_at DESC').paginate(page: params[:page], per_page: 5)
  end

  def new
    @user = User.new
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Welcome to AeroFlow, #{@user.username}! You have successfully signed up!"
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def destroy
    @user.destroy
    session[:user_id] = nil if @user == current_user
    redirect_to root_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def require_same_user
    if current_user != @user && !current_user.admin?
      flash[:danger] = 'You cannot change or view other profiles unless you are an admin'
      redirect_to @user
    end
  end
end
