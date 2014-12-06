module SessionsHelper

	def sign_in(user)
		cookies.permanent[:remember_token] = user.remember_token
		self.current_user = user #calls the setter
	end

	def sign_out
		cookies.delete(:remember_token)
		self.current_user = nil
	end

	#setter for current user
	def current_user=(user)
		@current_user = user
	end

	#Getter for current user
	def current_user
		if @current_user.nil?
			@current_user = User.find_by_remember_token(cookies[:remember_token])
		end
		@current_user
	end

	#check to see if the user is signed in
	def signed_in?
        !current_user.nil?
    end

    #action is a string passed from controllers
    def signed_in_user
    	unless signed_in?
          store_location
          flash[:danger] = "Please Sign in first."
          redirect_to signin_path
        end
    end

    def current_user?(user)
        user == current_user
    end

    def redirect_back_or(default)
	    redirect_to(session[:forwarding_url] || default)
	    session.delete(:forwarding_url)
  	end

  # Stores the URL trying to be accessed.
  def store_location
    session[:forwarding_url] = request.url if request.get?
  end
end
