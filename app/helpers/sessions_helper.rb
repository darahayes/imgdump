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

    def signed_in_user
    	unless signed_in?
    		flash[:notice] = "Please sign in"
    		redirect_to signin_url
    	end
    end

    def current_user?(user)
        user == current_user
      end
end
