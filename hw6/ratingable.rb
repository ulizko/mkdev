module Ratingable
  
  def rate(user_rate, time_rate = Time.now)
    @user_rate = user_rate
    @time_rate = time_rate if time_rate.is_a? Time
  end
  
  def get_recommendation(list)
    list.sort_by{ |v| v.rating * v.class::WEIGHT * rand }.last(5)
  end
  
  def get_recommendation_watch(list)
    list.sort_by{ |val| val.time_watch }.reverse.sort_by.with_index{ |mov, ind| mov.
      user_rate * (1+ind)/10 * rand }.last(5)
  end
  
end