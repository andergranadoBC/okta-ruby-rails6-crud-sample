class SessionsController < ApplicationController
  def new
  end

  def create
  end

  def destroy
    session[:oktastate] = nil
    session[:groups] = nil
    session[:domain] = nil
    session[:store] = nil
    @current_user = session[:oktastate]
    @session = session[:oktastate]
    @groups = session[:domain]
    @store = session[:store]
    redirect_to root_path
  end
end