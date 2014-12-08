class FavoritesController < ApplicationController
  before_filter :signed_in_user

def create
    @photo = Photo.find(params[:photo_id])
    current_user.favorite(@photo)
    respond_to do |format|
      format.html { redirect_to @photo }
      format.js
    end
  end

  def destroy
    @photo = Favorite.find(params[:id]).photo
    current_user.unfavorite(@photo)
    respond_to do |format|
      format.html { redirect_to @photo }
      format.js
    end
  end
end