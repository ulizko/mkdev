require_relative 'rateable_movie.rb'

class ModernMovie < RateableMovie
  
  WEIGHT = 4
  
  def to_s
    "%s - is modern movie, starring %s" % [title, actors.join(", ")]
  end

end