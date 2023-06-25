class UrlsController < ApplicationController
  def create
    @url = Url.create!(url_params)
    @url.update!(user: current_user) if current_user
    @url.update!(short_url: "#{request.base_url}/#{@url.short_code}")

    render json: { short_link: @url.short_url }, status: :created
  end

  def redirect
    @url = Url.find_by!(short_code: params[:short_code])

    return unless @url

    @url.increment!(:count)
    render json: { url: @url.original_url }, status: :ok
  end

  def url_stats
    @url = Url.find_by!(short_code: params[:short_code])

    if @url
      render json: { count: @url.count }, status: :ok
    else
      render json: { errors: "URL not found" }, status: :not_found
    end
  end

  private

    def url_params
      params.permit(:original_url)
    end
end
