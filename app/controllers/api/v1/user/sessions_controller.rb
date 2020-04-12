class Api::V1::User::SessionsController < Api::V1::User::AppController
  skip_before_action :set_current_user, only: [:create]

  def create
    user = User.find_by_email(params[:user][:email])
    raise GKAuthenticationError.new("Invalid Email") if user.blank?
    # GKAuthenticationError.new("please check your email for verification email") if !user.confirmed?
    if user.valid_password?(params[:user][:password])
      # user.generate_auth_token
      # user.reload
      render json: { success: true, user: user.sign_in_json }
    else
      raise GKAuthenticationError.new("Invalid Email or Password")
    end
  end

  def destroy
    current_user.generate_auth_token(true)
    render json: { success: true }
  end

  def me
    render json: current_user.as_me_json
  end
end
