class CommentsController < ApplicationController
	
	def show
	end

	def create
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
	
end