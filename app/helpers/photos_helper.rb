module PhotosHelper

def image(photo)
	photo.image if photo.image else photo.remote_image_url
end

end