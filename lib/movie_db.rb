require "themoviedb"
require "date"

class MovieDB
  
  API_KEY = "49f9fa36e35148764b75d87d4a894fa2"
  
  def initialize(title)
    Tmdb::Api.key(API_KEY)
    @movie = Tmdb::Movie.find(title).first
  end
  
  def title 
    @movie.original_title
  end
  
  def year 
    Date.strptime(release, "%Y-%m-%d").year
  end
  
  def release
    @movie.release_date
  end
  
  def country
    details["production_countries"].map { |v| v["name"] }
  end
  
  def genre
    details["genres"].map { |v| v["name"] }.sort
  end
  
  def duration
    details["runtime"]
  end
  
  def rating
    details["vote_average"]
  end
  
  def director
    Tmdb::Movie.credits(id)["crew"].first["name"]
  end
  
  def actors
    Tmdb::Movie.casts(278).map { |v| v["name"] }.first(3)
  end
  
  def id
    @movie.id
  end
  
  def details
    Tmdb::Movie.detail(id)
  end
  
end