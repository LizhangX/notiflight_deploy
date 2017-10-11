class User < ApplicationRecord
    has_secure_password
    has_many :flights, dependent: :destroy

    validates :name, :email, :image, presence: true
    validates :password, on: :create, length: { minimum: 8 }
    validates :email, uniqueness: true, format: { with: /(\A([a-z]*\s*)*\<*([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\>*\Z)/i }
    before_save :downcase_email    

    def downcase_email
        self.email.downcase!
    end

    def self.from_omniauth(auth)
        where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
          user.provider = auth.provider
          user.uid = auth.uid
          user.password = auth.uid
          user.name = auth.info.name
          user.email = auth.info.email
          user.image = auth.info.image
          user.oauth_token = auth.credentials.token
          user.oauth_expires_at = Time.at(auth.credentials.expires_at)
          puts "inside user"
          if user.valid?
            user.save!
            return user
          else
            return false
          end
        end
    end
end
