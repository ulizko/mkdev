require_relative 'movie.rb'
require_relative 'ratingable.rb'

class AncientMovie < Movie
  include Ratingable
  
  WEIGHT = 1
  
  def initialize(fields, user_rate = nil, time_watch = nil)
    super(fields, user_rate, time_watch)
  end
  
  def to_s
    "#{title} - is old movie (#{year})"
  end

end