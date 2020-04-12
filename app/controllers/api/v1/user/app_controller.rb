class Api::V1::User::AppController < Api::AppController
  before_action :set_current_user

  def current_user
    @current_user
  end

  def set_current_user
    auth_header = request.headers["auth-token"]
    raise GKAuthenticationError.new("Not logged in") if auth_header.blank?
    auth_split = auth_header.split(" ")
    raise GKAuthenticationError.new("Not logged in") if auth_split.first != "Bearer"
    auth_jwt = auth_split.last
    payload = ApiJwt.decrypt_jwt(auth_jwt, Rails.application.credentials.user_jwt_secret) rescue nil
    raise GKAuthenticationError.new("Not logged in") if payload.blank? || payload["auth_token"].blank?
    @current_user = User.find_by_auth_token(payload["auth_token"])
  end
end
