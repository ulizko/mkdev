require_relative 'rateable_movie.rb'

class ClassicMovie < RateableMovie
  
  WEIGHT = 3
  
  def to_s
    "%s - is classic movie, director: %s" % [title, director]
  end

end