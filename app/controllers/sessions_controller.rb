class SessionsController < ApplicationController

	def new
	end

	def create
		user = User.find_by_email(params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password])
          # Sign the user in and redirect to the user's show page.
          sign_in user #Calls the sign in method in helpers/sessions_helper.rb
          redirect_back_or user
        else
          flash[:error] = 'Invalid email/password combination'
          redirect_to signin_path
        end
	end

	def destroy
		sign_out
		redirect_to root_url
	end

	 # Redirects to stored location (or to the default).
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # Stores the URL trying to be accessed.
  def store_location
    session[:forwarding_url] = request.url if request.get?
  end

end
