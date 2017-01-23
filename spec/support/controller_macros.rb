module ControllerMacros
  def auth_user(user)
    request.env["devise.mapping"] = Devise.mappings[:user]
    request.headers.merge! user.create_new_auth_token
    sign_in user
  end
end