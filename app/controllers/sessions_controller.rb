class SessionsController < ApplicationController
  before_action :redirect_logged_in, only: [:new, :create]
  
  def new
  end
  
  def create
    user = User.find_by(email: params[:email])
    
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash[:danger] = "Incorrect Email and/or Password"
      render 'new'
    end
  end
  
  def destroy
    session[:user_id] = nil
    flash[:success] = "You are signed out."
    redirect_to root_path
  end
  
end