require_relative 'movie.rb'
require_relative 'ratingable.rb'

class ModernMovie < Movie
  include Ratingable
  
  WEIGHT = 4
  
  def initialize(fields, user_rate = nil, time_watch = nil)
    super(fields, user_rate, time_watch)
  end
  
  def to_s
    "%s - is modern movie, starring %s" % [title, actors.join(", ")]
  end

end