class BirdsController < ApplicationController
  def index
    require "uri"
    require "net/http"

    url = URI("https://api.ebird.org/v2/data/obs/geo/recent?lat=#{params[:lat]}&lng=#{params[:lng]}")
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["X-eBirdApiToken"] = "#{Rails.application.credentials.api_key}"

    response = https.request(request)
    # puts response.read_body
    render json: response.read_body
  end
end

# http://localhost:3000/birds?lat=34&lng=-118

# def index
#   require "uri"
#   require "net/http"

#   url = URI("https://api.ebird.org/v2/data/obs/geo/recent?lat=34.03&lng=-118.05&sort=species")
#   # https://api.ebird.org/v2/data/obs/geo/recent?lat={{lat}}&lng={{lng}}

#   https = Net::HTTP.new(url.host, url.port)
#   https.use_ssl = true

#   request = Net::HTTP::Get.new(url)
#   request["X-eBirdApiToken"] = "#{Rails.application.credentials.api_key}"

#   response = https.request(request)
#   # puts response.read_body
#   render json: response.read_body
# end
