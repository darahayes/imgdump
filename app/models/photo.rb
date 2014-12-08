class Photo < ActiveRecord::Base
	belongs_to :user
	has_many :comments, dependent: :destroy
	accepts_nested_attributes_for :comments
	mount_uploader :image, PhotoUploader
	validate  :image_size
	#validate  :file_type

	# Validates the size of an uploaded picture.
    def image_size
      if image.size > 5.megabytes
        errors.add(:image, "should be less than 5MB")
      end
    end

    def file_type
    	accepted_types = [".png", ".gif", ".jpeg", ".jpg", ".bmp"]
    	unless accepted_types.include? File.extname image.to_s
    		errors.add(:image, "Accepted file types include: .png, .gif, .jpg, .bmp") 
    	end
    end

end
