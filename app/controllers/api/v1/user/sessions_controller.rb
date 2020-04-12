class Api::V1::User::SessionsController < Api::V1::User::AppController
  def create
    user = User.find_by_email(params[:user][:email])
    raise GKAuthenticationError.new("Invalid Email") if user.blank?
    # GKAuthenticationError.new("please check your email for verification email") if !user.confirmed?
    if user.valid_password?(params[:user][:password])
      # user.reset_authentication_token
      render json: { success: true, user: user.sign_in_json }
    else
      raise GKAuthenticationError.new("Invalid Email or Password")
    end
  end
end
