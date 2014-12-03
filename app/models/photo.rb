class Photo < ActiveRecord::Base
	belongs_to :user
	has_many :votes, :as => :posts
	mount_uploader :image, PhotoUploader
end
