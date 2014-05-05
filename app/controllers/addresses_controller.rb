require 'open-uri'
require 'json'

class AddressesController < ApplicationController
  def fetch_coordinates
    # @address = "the corner of Foster and Sheridan"
    @address = params[:address]
    if @address == nil
      @url_safe_address = URI.encode("the corner of Foster and Sheridan")
    else
      @url_safe_address = URI.encode(@address)
    end

    # Your code goes here.
    url = "http://maps.googleapis.com/maps/api/geocode/json?address=#{@url_safe_address}+&sensor=false"
    raw_data = open(url).read
    parsed_data = JSON.parse(raw_data)
    if parsed_data["results"][0] != nil
        @latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]
        @longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]
    else
        @latitude = 0.0
        @longitude = 0.0
    end
  end
end
