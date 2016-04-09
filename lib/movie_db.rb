require "themoviedb"

class MovieDB
  
  API_KEY = "49f9fa36e35148764b75d87d4a894fa2"
  
  def initialize(title)
    Tmdb::Api.key(API_KEY)
    Tmdb::Movie.find(title)
  end
  
end