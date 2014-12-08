class Comment < ActiveRecord::Base
	belongs_to :photo
	belongs_to :user
	default_scope order: 'comments.created_at DESC'
	validates :text, presence: true, allow_blank: false

end