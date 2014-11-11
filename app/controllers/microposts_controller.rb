class MicropostsController < ApplicationController
	before_filter :correct_user, only: :destroy 
	#Ensure the a delete request can only be sent to a micropost owned by the user 
	before_filter :signed_in_user, only: [:create, :destroy]
	#ensures the signed in user method is called before create or destroy

	def create
		secure_post = params.require(:micropost).permit(:content)
		@micropost = current_user.microposts.build(secure_post)
		if @micropost.save
			flash[:success] = "Micropost created!"
			redirect_to root_url
		else
			@feed_items = []     # NEW LINE
			render 'static_pages/home'
		end
	end

	def destroy
		@micropost.destroy
		redirect_to root_url
	end

	private
		def correct_user
			@micropost = current_user.microposts.find_by_id(params[:id])
			redirect_to root_url if @micropost.nil?
		end

end