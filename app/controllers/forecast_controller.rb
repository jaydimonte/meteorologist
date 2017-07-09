require 'open-uri'

class ForecastController < ApplicationController
  def coords_to_weather_form
    # Nothing to do here.
    render("forecast/coords_to_weather_form.html.erb")
  end

  def coords_to_weather
    @lat = params[:user_latitude]
    @lng = params[:user_longitude]

    # ==========================================================================
    # Your code goes below.
    # The latitude the user input is in the string @lat.
    # The longitude the user input is in the string @lng.
    # ==========================================================================

    require 'open-uri'
    
    @url = "https://api.darksky.net/forecast/66756d9c893a137121786228a002a9c7/" + @lat + "," + @lng
  
    @raw_data = open(@url).read
    
    @parsed_data = JSON.parse(@raw_data)

    @current_temperature = @parsed_data.dig("currently", "temperature")

    @current_summary =  @parsed_data.dig("currently", "summary")

    @summary_of_next_sixty_minutes =  @parsed_data.dig("minutely", "summary")

    @summary_of_next_several_hours = @parsed_data.dig("hourly", "summary")

    @summary_of_next_several_days = @parsed_data.dig("daily", "summary")

    render("forecast/coords_to_weather.html.erb")
  end
end
