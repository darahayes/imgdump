class PhotosController < ApplicationController
before_filter :correct_user, only: :destroy
	def new
		if signed_in?
			@photo = Photo.new()
		else
			flash[:error] = "You must be signed in to upload an image"
			redirect_to signin_path
		end
	end

	def show
		@photo = Photo.find_by_id(params[:id]) or render_404
		@comments = @photo.comments
	end

	def create
		if signed_in?
			secure_params = params.require(:photo).permit(:title, :image, :remote_image_url)
			current_user.photos.create(secure_params)
			flash[:success] = "Photo Uploaded"
			redirect_to current_user
		else
			redirect_to root_url
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