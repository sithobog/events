class User < ActiveRecord::Base
  devise :registerable, :omniauthable, omniauth_providers: [:google_oauth2]
  def self.from_omniauth(access_token)
      data = access_token.info
      user = User.find_by(email: data["email"])

      unless user
          user = User.create(name: data["name"],
             email: data["email"],
          )
      end
      user
  end
end
