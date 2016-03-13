require_relative 'movie.rb'
require_relative 'ratingable.rb'

class NewMovie < Movie
  include Ratingable
  
  attr_accessor :user_rate, :time_watch, :weight
  
  def initialize(fields, user_rate = nil, time_watch = nil)
    super(fields)
    @user_rate, @time_watch = user_rate, time_watch
    @weight = 5
  end
  
  def to_s
    "#{title} - is new movie, grossed more than $100 millions"
  end

end