class PhotosController < ApplicationController
before_filter :correct_user, only: :destroy
before_filter :signed_in_user, only: [:create, :new]
	

	def new
			@photo = Photo.new()
	end

	def show
		@photo = Photo.find_by_id(params[:id])
		if @photo
			@comments = @photo.comments  
		else 
			render_404 
		end
	end

	def create
			secure_params = params.require(:photo).permit(:title, :image, :remote_image_url)
			@photo = current_user.photos.create(secure_params)
			if @photo.save
				flash[:success] = "Photo Uploaded"
				redirect_to @photo
			else
				render 'new'
			end
	end

	def destroy
		if signed_in?
			@photo.destroy
			flash[:success] = "Photo Deleted"
			redirect_to current_user
		else
			flash[:error] = "You must be signed in to delete a photo"
			redirect_to root_url
		end
	end

	private
		def correct_user
			@photo = current_user.photos.find_by_id(params[:id])
			redirect_to root_url if @photo.nil?
		end
end