require_relative 'movie.rb'
require_relative 'ratingable.rb'

class ClassicMovie < Movie
  include Ratingable
  
  WEIGHT = 3
  
  def initialize(fields, user_rate = nil, time_watch = nil)
    super(fields, user_rate, time_watch)
  end
  
  def to_s
    "%s - is classic movie, director: %s" % [title, director]
  end

end