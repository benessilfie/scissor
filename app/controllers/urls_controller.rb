class UrlsController < ApplicationController
  def create
    @url = Url.create!(url_params)
    @url.update!(user: current_user) if current_user
    @url.update!(short_url: "#{request.base_url}/#{@url.short_code}")

    render json: { short_url: @url.short_url, short_code: @url.short_code }, status: :created
  end

  def redirect
    @url = Url.find_by!(short_code: params[:short_code])

    return unless @url

    @url.increment!(:count)
    corrected_url = @url.original_url.gsub(/^w{4}\./, "")
    redirect_to URI::HTTP.build(host: corrected_url).to_s, allow_other_host: true
  end

  def url_stats
    @url = Url.find_by!(short_code: params[:short_code])

    if @url
      render json: { number_of_times_visted: @url.count }, status: :ok
    else
      render json: { errors: "URL not found" }, status: :not_found
    end
  end

  private

    def url_params
      params.permit(:original_url)
    end
end
