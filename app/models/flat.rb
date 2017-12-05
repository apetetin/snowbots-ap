class Flat
  attr_accessor :location, :id_homeaway, :price_by_night, :photo, :domain

  def initialize(attributes = {})
    @location = attributes[:location]
    @id_homeaway = attributes[:id_homeaway]
    @price_by_night = attributes[:price_by_night]
    @photo = attributes[:photo]
    @domain = attributes[:domain]
    @ratings = attributes[:ratings]
  end
end