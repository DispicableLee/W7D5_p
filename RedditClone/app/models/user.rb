# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  username        :string           not null
#  session_token   :string           not null
#  password_digest :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
        before_validation :ensure_session_token
    validates :username, :session_token, presence: true, uniqueness: true
    validates :password_digest, presence: true
    validates :password, length: {minimum: 6, allow_nil: true}

# figvapebr
    attr_reader :password
    
    def self.find_by_credentials(username, password)
        @user = User.find_by(username: username)
        if @user && @user.is_password?(password)
            @user
        else
            nil
        end
    end


    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end


    def is_password?(password)
        BCrypt::Password.new(self.password_digest).is_password?(password)
    end


    def reset_session_token!
        self.session_token = generate_session_token
        self.save!
        self.session_token
    end

    has_many :subs,
        class_name: 'Sub',
        foreign_key: :moderator_id,
        dependent: :destroy


    private
    # def user_params
    #     params.require(:user).permit(:username, :password)
    # end


    def generate_session_token
        SecureRandom::urlsafe_base64
    end

    def ensure_session_token
        self.session_token ||=generate_session_token
    end

end
