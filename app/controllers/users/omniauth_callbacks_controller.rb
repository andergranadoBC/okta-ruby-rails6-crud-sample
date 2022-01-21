class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
    # def okta
   def oktaoauth
      @groups = request.env["omniauth.auth"]["extra"]["raw_info"]["groups"]
      @domain = request.env["omniauth.auth"]['info']['email'].partition('@').last

      session[:groups] = @groups
      session[:domain] = @domain

      @customer_groups = Array.new
      @groups.each do |group|
         if group.starts_with?("CUSTOMER")
            @customer_groups << group
         end
      end

      @user = User.from_omniauth(request.env["omniauth.auth"])
      session[:oktastate] = request.env["omniauth.auth"]["uid"]


      if @customer_groups.count == 1
         session[:store] = @customer_groups[0]
         redirect_to root_path
      else
         redirect_to pages_client_selection_path
      end
   end
end