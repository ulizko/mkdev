module Ratingable
  
  def probabilities (list, field)
    sum = list.map { |v| v.send(field).to_f }.uniq.reduce(:+)
    probability = 0.0
    probability_for = list.map{ |v| v.send(field).to_f }.uniq.sort.map do |el|
      current = (el / sum).round(3)
      probability += current
      eval "{ #{field}: #{el}, probability: #{probability}}"
    end
    probability_for
  end
  
  def movie_probability(list, *field)
      movie_probability = list.map do |m|
        probability_1 = probabilities(list, field.first).select{ |val| val[field.first] == m.send(field.first)}.map{ |v| v[:probability]}.first
        probability_2 = probabilities(list, field.last).select{ |val| val[field.last] == m.send(field.last)}.map{ |v| v[:probability]}.first
        sum_probability = field.size > 1 ? (probability_1 * probability_2).round(4) : probability_1
        {title: m.title, probability: sum_probability}
      end
      movie_probability.sort_by{ |v| v[:probability] }
  end
  
  def get_value(probabilities)
    r = rand
    probabilities.each{ |prob| return prob[:title] if r < prob[:probability] }
  end
  
  def get_movie(list, criterion)
    list.select{ |v| v.title == criterion}.join
  end
  
  def get_recommendation(list, *field)
    result = []
    until result.size == 5 do
      criterion = get_value(movie_probability(list, field.first, field.last))
      mov = get_movie(list, criterion)
      result << mov unless mov.empty? || result.include?(mov)
    end
    result
  end
  
end