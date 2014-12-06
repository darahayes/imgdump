class CommentsController < ApplicationController
	before_filter :correct_user, only: :destroy
	before_filter :check_signed_in, only: [:new, :create, :destroy]
	
	def index
		@user = User.find_by_id(params[:user_id])
		if @user
			@comments = @user.comments
		end
	end

	def create
		if signed_in?
			secure_post = params.require(:comment).permit(:text)
			@photo = Photo.find_by_id(params[:photo_id])
			@comment = @photo.comments.build(secure_post)
			@comment.user_id = current_user.id
			if @comment.save
				flash[:success] = "comment posted"
				redirect_to @photo
			else
				redirect_to @photo
			end
		else
			flash[:warning] = "Please sign in first"
			redirect_to signin_path
		end
	end

	def destroy
	    @photo = Photo.find(params[:photo_id])
	    @comment = Comment.find(params[:id])
	    @comment.destroy

	    respond_to do |format|
	      format.html { redirect_to @photo}
	      format.xml  { head :ok }
	  end
    end

  	private
		def correct_user
			@comment = current_user.comments.find_by_id(params[:id])
			redirect_to root_url if @comment.nil?
		end

		def check_signed_in
	    	unless signed_in?
	          store_photo_location
	          flash[:danger] = "Please Sign in first."
	          redirect_to signin_path
	     	end
	    end

	    def store_photo_location
    		session[:forwarding_url] = photo_path(params[:photo_id])
  		end
	
end