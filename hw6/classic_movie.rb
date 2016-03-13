require_relative 'movie.rb'
require_relative 'ratingable.rb'

class ClassicMovie < Movie
  include Ratingable
  
  attr_accessor :user_rate, :time_watch, :weight
  
  def initialize(fields, user_rate = nil, time_watch = nil)
    super(fields)
    @user_rate, @time_watch = user_rate, time_watch
    @weight = 3
  end
  
  def to_s
    "%s - is classic movie, director: %s" % [title, director]
  end

end