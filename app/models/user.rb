class User < ActiveRecord::Base
<<<<<<< HEAD
    has_many :microposts, dependent: :destroy #indicates association with micropost
    #also deletes any microposts associated with a user if the user is deleted
=======
    has_many :photos, dependent: :destroy
    has_many :votes
>>>>>>> sign-in-out
	before_save do |user| 
        user.email = email.downcase 
        user.remember_token = SecureRandom.urlsafe_base64
        end #Creates a "remember-me token"
    validates :name, presence: true, length: { in: 9..30 }
    validates :password, presence: true, length: { minimum: 6 }
    validates :password_confirmation, presence: true
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, 
                        format: { with: VALID_EMAIL_REGEX },
                        uniqueness: { case_sensitive: false }
    has_secure_password      # A magic method!!

    def feed
        Micropost.where("user_id = ?", id)
    end
end 