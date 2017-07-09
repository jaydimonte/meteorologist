require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("meteorologist/street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]

    # ==========================================================================
    # Your code goes below.
    #
    # The street address that the user typed is in the variable @street_address.
    # ==========================================================================

    require 'open-uri'

    @url0 = "https://maps.googleapis.com/maps/api/geocode/json?address=" + @street_address.gsub(" ","+")
  
    @raw_data = open(@url0).read
    
    @parsed_data = JSON.parse(@raw_data)

    @latitude = @parsed_data["results"][0]["geometry"]["location"]["lat"]

    @longitude = @parsed_data["results"][0]["geometry"]["location"]["lng"]
    
    require 'open-uri'

    @url = "https://api.darksky.net/forecast/66756d9c893a137121786228a002a9c7/" + @latitude.to_s + "," + @longitude.to_s
  
    @raw_data = open(@url).read
    
    @parsed_data = JSON.parse(@raw_data)

    @current_temperature = @parsed_data.dig("currently", "temperature")

    @current_summary =  @parsed_data.dig("currently", "summary")

    @summary_of_next_sixty_minutes =  @parsed_data.dig("minutely", "summary")

    @summary_of_next_several_hours = @parsed_data.dig("hourly", "summary")

    @summary_of_next_several_days = @parsed_data.dig("daily", "summary")

    render("meteorologist/street_to_weather.html.erb")
  end
end
