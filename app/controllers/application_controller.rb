class ApplicationController < ActionController::API
  skip_before_action :verify_authenticity_token, raise: false

  include Authenticable
  include ErrorHandler

  rescue_from StandardError, with: :error_handler

  def healthcheck
    render json: { message: "Welcome to the scissors API" }, status: :ok
  end
end
