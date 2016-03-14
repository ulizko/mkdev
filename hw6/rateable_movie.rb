require_relative 'movie'
class RateableMovie < Movie
  
  attr_reader :user_rate, :time_watch 
  
  def initialize(fields, user_rate, time_watch)
    super(fields)
    @user_rate, @time_watch = user_rate, time_watch
  end
  
  def rate(user_rate, time_rate = Time.now)
    @user_rate = user_rate
    @time_rate = time_rate if time_rate.is_a? Time
  end
  
  def unwatched?
    self.time_watch.nil?
  end
  
  def days_after_watching
    (Time.now - self.time_watch) / (60 * 60 * 24)
  end
end