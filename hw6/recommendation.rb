module Recommendation
  
  def get_recommendation
    @movies_list.select(&:unwatched?).sort_by{ |v| v.rating * v.class::WEIGHT * rand }.last(5)
  end
  
  def get_recommendation_watched
    @movies_list.reject(&:unwatched?).sort_by{ |mov| mov.user_rate * mov.days_after_watching * 0.01 * rand }.last(5)
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