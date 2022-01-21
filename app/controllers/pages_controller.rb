class PagesController < ApplicationController
  before_action :user_is_logged_in?, except: :home

  def home
    puts(session[:oktastate])
    @current_user = User.find_by(uid: session[:oktastate])
    @groups = session[:groups]
    @domain = session[:domain]
    
    # Loads store info from session or matches the selected store from the session info
    @store = session[:store]
    if @store.nil?
      if session[:groups].include? params[:store]
        @store = params[:store]
      end
    end
  end

  def account
    @current_user = User.find_by(uid: session[:oktastate])
    puts(session[:oktastate])
  end

  def client_selection
    @current_user = User.find_by(uid: session[:oktastate])
    @groups = session[:groups]
  end
end