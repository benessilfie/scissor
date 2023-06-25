class UserUpdater < ApplicationService
  def initialize(user, user_params = {})
    @user = user
    @email = user_params[:email] || @user.email
    @username = user_params[:username] || @user.username
  end

  def call
    update_user
  end

  private

    def update_user
      @user.update!(email: @email, username: @username)
    end
end
