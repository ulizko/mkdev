require_relative 'rateable_movie.rb'

class ClassicMovie < RateableMovie
  
  WEIGHT = 3
  
  def initialize(fields, user_rate = nil, time_watch = nil)
    super
  end
  
  def to_s
    "%s - is classic movie, director: %s" % [title, director]
  end

end