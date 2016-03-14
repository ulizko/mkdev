require_relative 'rateable_movie.rb'

class NewMovie < RateableMovie
  
  WEIGHT = 5
  
  def initialize(fields, user_rate = nil, time_watch = nil)
    super
  end
  
  def to_s
    "#{title} - is new movie, grossed more than $100 millions"
  end

end