Rails.application.routes.draw do
  root to: "application#healthcheck"
  post "/", to: "graphql#execute"

  def healthcheck
    render json: { message: "OK" }, status: :ok
  end
end
