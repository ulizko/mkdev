module Recommendation
  
  def get_recommendation(list)
    list.sort_by{ |v| v.rating * v.class::WEIGHT * rand }.last(5)
  end
  
  def get_recommendation_watch(list)
    list.sort_by{ |mov| mov.user_rate * mov.days_after_watching * 0.01 * rand }.last(5)
  end
  
end