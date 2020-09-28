# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      session[:user_id] = user.id
      # flash[:success] = 'Logged in successfully'
      redirect_to user
    else
      # flash.now[:danger] = 'The email/password combination you entered is incorrect.'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    # flash[:success] = "Log out successful"
    redirect_to root_path
  end
end
