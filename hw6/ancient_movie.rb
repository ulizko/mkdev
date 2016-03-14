require_relative 'rateable_movie.rb'

class AncientMovie < RateableMovie
  
  WEIGHT = 1
  
  def initialize(fields, user_rate = nil, time_watch = nil)
    super
  end
  
  def to_s
    "#{title} - is old movie (#{year})"
  end

end