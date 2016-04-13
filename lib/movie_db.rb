require 'bundler/setup'
require "themoviedb"
require "date"
require 'json'

class MovieDB
  
  API_KEY = "49f9fa36e35148764b75d87d4a894fa2"
  
  def MovieDB.build
    @movies_list = get_list.map do |imdb_id|
      movie = new(imdb_id)
        { title: movie.titles,
          year: movie.year,
          country: movie.country,
          release: movie.release,
          genre: movie.genre,
          duration: movie.duration,
          rating: movie.rating,
          director: movie.director,
          actors: movie.actors }
    end
  end
  
  def initialize(imdb)
    Tmdb::Api.key(API_KEY)
    @movie = Tmdb::Find.imdb_id(imdb)["movie_results"].first
    @detail = Tmdb::Movie.detail(id)
  end
  
  def titles 
    sleep(0.2)
    @detail["title"]
  end
  
  def year
    sleep(0.2)
    Date.strptime(release, "%Y-%m-%d").year
  end
  
  def release
    sleep(0.2)
    @detail["release_date"]
  end
  
  def country
    sleep(0.2)
    @detail["production_countries"].map { |v| v["name"] }
  end
  
  def genre
    sleep(0.2)
    @detail["genres"].map { |v| v["name"] }.sort
  end
  
  def duration
    sleep(0.2)
    @detail["runtime"]
  end
  
  def rating
    sleep(0.2)
    @detail["vote_average"]
  end
  
  def director
    sleep(0.2)
    Tmdb::Movie.crew(id).detect { |v| v["job"] == "Director" }["name"]
  end
  
  def actors
    sleep(0.2)
    Tmdb::Movie.casts(id).map { |v| v["name"] }.first(3)
  end
  
  def id
    @movie["id"]
  end
  
  def MovieDB.get_list
    file = File.read("#{File.expand_path(File.dirname(__FILE__))}/movie.json")
    JSON.parse(file).map { |v| v["url"].slice(/tt\d+/) }
  end
  
end