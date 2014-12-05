class Photo < ActiveRecord::Base
	belongs_to :user
	has_many :votes, :as => :posts
	has_many :comments
	accepts_nested_attributes_for :comments
	mount_uploader :image, PhotoUploader
end
