# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = 'Logged in successfully'
      redirect_to questions_path
    else
      flash.now[:danger] = 'The email/password combination you entered is incorrect.'
      render 'new'
    end
  end

  def oauth
    auth_hash = request.env['omniauth.auth']
    oauth_email = auth_hash['info']['email']
    if user = User.find_by(email: oauth_email)
      session[:user_id] = user.id
      redirect_to questions_path
    else
      user = User.new(username: auth_hash['info']['name'], email: oauth_email, password: SecureRandom.hex)
      if user.save
        session[:user_id] = user.id
        redirect_to user
      else
        redirect_to login_path
      end
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'Log out successful'
    redirect_to root_path
  end
end
