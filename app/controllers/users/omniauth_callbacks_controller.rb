class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # def okta
  def oktaoauth

    # Loads info received from Okta into Rails session 
    @user = User.from_omniauth(request.env["omniauth.auth"])
    @groups = request.env["omniauth.auth"]["extra"]["raw_info"]["groups"]
    @domain = request.env["omniauth.auth"]['info']['email'].partition('@').last
    session[:oktastate] = request.env["omniauth.auth"]["uid"]
    session[:groups] = @groups
    session[:domain] = @domain

    # Checks the groups that starts with CUSTOMER to get all the stores accesible for that user
    @customer_groups = Array.new
    @groups.each do |group|
      if group.starts_with?("CUSTOMER")
        @customer_groups << group
      end
    end

    # If the user have only access to a single store, it redirects to that
    # If the user belongs to different stores (staff users), are redirected to store selection pages
    if @customer_groups.count == 1
      session[:store] = @customer_groups[0]
      redirect_to root_path
    else
      redirect_to pages_client_selection_path
    end
  end
end