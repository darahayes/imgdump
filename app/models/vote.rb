class Vote < ActiveRecord::Base
	belongs_to :posts, :polymorphic => true
end
