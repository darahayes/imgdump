class Status < ActiveRecord::Base
	has_one :photo
	has_one :comment
	has_many :votes
end
