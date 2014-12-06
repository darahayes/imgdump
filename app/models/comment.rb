class Comment < ActiveRecord::Base
	has_many :votes, :as => :posts, dependent: :destroy
	belongs_to :photo
	belongs_to :user
	default_scope order: 'comments.created_at DESC'
	validates :text, presence: true, allow_blank: false

end