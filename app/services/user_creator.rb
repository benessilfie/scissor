class UserCreator < ApplicationService
  def initialize(user_params = {})
    @email = user_params[:email]
    @username = user_params[:username]
    @password = user_params[:password]
    @password_confirmation = user_params[:password_confirmation]
  end

  def call
    create_user
  end

  private

    def create_user
      User.create!(email: @email, username: @username, password: @password, password_confirmation: @password_confirmation)
    end
end
