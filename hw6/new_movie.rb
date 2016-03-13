require 'date'
require_relative 'movie.rb'
class NewMovie < Movie
  #extend Ratingable
  attr_accessor :user_rate, :time_watch, :weight
  attr_accessor :url, :title, :year, :country, 
                :release, :genres, :duration, 
                :rating, :director, :actors 
  
  def initialize(fields, weight, user_rate = nil, time_watch = 0)
    super(fields)
    @weight, @user_rate, @time_watch = weight, user_rate, time_watch
  end
  
  def user_rate=(rating)
    @user_rate = rating
    @time_watch = Time.now
  end
  
  def time_watch=(time)
    time = time.split(/[-,.]/),join("-")
    @time_watch = Date.strptime(time, '%Y-%m-%d').to_time
  end
  
  def to_s
    "#{title} - is new movie, grossed more than $100 millions"
  end

end