class User < ActiveRecord::Base
    has_many :photos, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many :votes
    accepts_nested_attributes_for :photos
	before_save do |user| 
        user.email = email.downcase 
        user.remember_token = SecureRandom.urlsafe_base64
        end #Creates a "remember-me token"
    validates :name, presence: true, length: { in: 1..50 }
    validates :password, length: { minimum: 6 }, allow_blank: true
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, 
                        format: { with: VALID_EMAIL_REGEX },
                        uniqueness: { case_sensitive: false }
    has_secure_password      # A magic method!!
end 