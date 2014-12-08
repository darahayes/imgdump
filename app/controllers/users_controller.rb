class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def index
    @users = User.paginate(page: params[:page])
  end

  def new
  	@user = User.new()
  end

  def show
      @user = User.find(params[:id])
      if @user.photos.any?
        @photos = @user.photos
      end
  end

  def create
    @user = User.new(user_params)
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


  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def comments
    @title = "Comments"
    @user = User.find(params[:id])
    @comments = @user.comments.paginate(page: params[:page])
    render 'show_comments'
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  def favorites
    @title = "Favorites"
    @user  = User.find(params[:id])
    @favorites = @user.favorite_photos.paginate(page: params[:page])
    render 'show_favorites'
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

    def comments
      if @user.comments.any?
            @comments = @user.comments
      end
    end
end
