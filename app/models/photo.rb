class Photo < ActiveRecord::Base
	belongs_to :user
	has_many :votes, :as => :posts, dependent: :destroy
	has_many :comments, dependent: :destroy
	accepts_nested_attributes_for :comments
	mount_uploader :image, PhotoUploader
end
