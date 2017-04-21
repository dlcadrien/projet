class City < ActiveRecord::Base
  before_validation :geocode
  
  def weather
    ForecastIO.forecast(self.latitude, self.longitude).currently
  end
  
  private # code below is private !!!
  def geocode
    places = Nominatim.search(self.name).limit(1)
    place = places.first
      if place
      self.latitude = place.latitude
      self.longitude = place.longitude
      end
  end
  
end