class UsersController < ApplicationController
  before_action :set_user, only: %i[show update destroy]

  def show
    options = { include: %i[urls] }
    render json: UserSerializer.new(@user, options).serializable_hash, status: :ok
  end

  def create
    @user = UserCreator.call(user_params)
    render json: UserSerializer.new(@user).serializable_hash, status: :created
  end

  def update
    UserUpdater.call(@user, user_params)
    render json: UserSerializer.new(@user).serializable_hash, status: :ok
  end

  def destroy
    @user.destroy
    head :no_content
  end

  private

    def user_params
      return params.permit(:username, :email) if action_name == "update"

      params.permit(:username, :email, :password, :password_confirmation)
    end

    def set_user
      @user = current_user
      return unless @user.nil?

      render json: { errors: ["You need to sign in or sign up before continuing"] }, status: :unauthorized
    end
end
