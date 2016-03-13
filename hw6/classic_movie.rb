require_relative 'movie.rb'
class ClassicMovie < Movie
  
  attr_accessor :user_rate, :time_watch, :weight
  
  def initialize(fields, weight, user_rate = nil, time_watch = 0)
    super(fields)
    @weight, @user_rate, @time_watch = weight, user_rate, time_watch
  end
  
  def user_rate=(rating)
    @user_rate = rating
    @time_watch = Time.now.to_i
  end
  
  def time_watch=(time)
    time = time.split(/[-,.]/),join("-")
    @time_watch = Date.strptime(time, '%Y-%m-%d').to_time.to_i
  end
  
  def to_s
    "%s - is classic movie, director: %s" % [title, director]
  end

end