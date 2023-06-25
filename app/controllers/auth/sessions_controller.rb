class Auth::SessionsController < ApplicationController
  def login
    value = user_params[:email] || user_params[:username]
    user = User.where("email = ? OR username = ?", value, value).first

    if user&.authenticate(user_params[:password])
      render json: { token: user.token }, status: :ok
    else
      render json: { error: "Invalid email or password" }, status: :unauthorized
    end
  end

  def logout
    current_user.update(auth_token: nil)
    head :no_content
  end

  private

    def user_params
      params.permit(:email, :username, :password)
    end
end
