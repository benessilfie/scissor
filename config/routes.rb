Rails.application.routes.draw do
  root to: "application#healthcheck"
  post "/", to: "graphql#execute"

  resources :users, except: %i[index]
  post "/shorten", to: "urls#create"
  get "/:short_code", to: "urls#redirect"
  get "/:short_code/stats", to: "urls#url_stats"

  namespace :auth, path: "/" do
    post "login", to: "sessions#login"
    delete "logout", to: "sessions#logout"
  end
end
