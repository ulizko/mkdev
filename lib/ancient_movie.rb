require_relative 'rateable_movie.rb'

class AncientMovie < RateableMovie
  
  WEIGHT = 1
  
  def to_s
    "#{title} - is old movie (#{year})"
  end

end