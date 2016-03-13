module Ratingable
  
  def rate(user_rate, time_rate = Time.now)
    @user_rate = user_rate
    @time_rate = time_rate if time_rate.is_a? Time
  end
  
  def get_recommendation(list, *field)
    list.sort_by{ |v| v.send(field.first) * v.send(field.last) * rand }.last(5)
  end
  
  def get_recommendation_watch(list, *field)
    list.sort_by{ |val| val.send(field.last) }.reverse.sort_by{ |mov| mov.
      send(field.first) * 0.next * rand }.last(5)
  end
  
end