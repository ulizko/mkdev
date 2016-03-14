require_relative 'movie.rb'
require_relative 'ratingable.rb'

class NewMovie < Movie
  include Ratingable
  
  WEIGHT = 5
  
  def initialize(fields, user_rate = nil, time_watch = nil)
    super(fields, user_rate, time_watch)
  end
  
  def to_s
    "#{title} - is new movie, grossed more than $100 millions"
  end

end