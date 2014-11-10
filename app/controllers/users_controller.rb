class UsersController < ApplicationController
  def new
  	@user = User.new()
  end

  def show
      @user = User.find(params[:id])
  end

  def create
        secure_params = params.require(:user).permit(:name, :email, 
                                  :password, :password_confirmation)
        @user = User.new(secure_params)
        if @user.save
           sign_in @user
           flash[:success] = "Welcome to the Twitter App!"    # NEW LINE
           redirect_to @user   # NEW LINE
           #render 'new' #code from tutorial. Causes problems
        else
            # Handle an unsuccessful save.
            render 'new'     # NEW LINE      
        end
    end
end
