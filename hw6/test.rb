movie = [{title: "Aaaaaaa", year: 1999, rating: 5.0, user_rate: nil, time_watch: nil, weight: 1},
        {title: "Bbbbbb", year: 2012, rating: 8.6, user_rate: nil, time_watch: nil, weight: 5}, 
        {title: "Cccccc", year: 1978, rating: 9.0, user_rate: nil, time_watch: nil, weight: 3}, 
        {title: "VVvvvv", year: 2005, rating: 8.2, user_rate: nil, time_watch: nil, weight: 4}, 
        {title: "Sssssss", year: 1980, rating: 8.8, user_rate: nil, time_watch: nil, weight: 3}, 
        {title: "Wwwww", year: 2011, rating: 9.0, user_rate: nil, time_watch: nil, weight: 5}]

def self.sum(*fields)
  self.map{ |v| [*v.send(fields)] }
end


sum_of_rating = movie.map do |v| 
  [v[:rating], v[:user_rate].to_i,  Time.now.to_i - v[:time_watch].to_i, v[:weight]]
end.reduce(:+)
p sum_of_rating
probablity = 0.0
rated_of_probablity = movie.map{ |v| v[:rating]}.uniq.sort.map do |r|
    current = (r / sum).round(3)
    probablity += current
    {rating: r, probablity: probablity.round(3)}
end
p rated_of_probablity

def get_rating rated_of_probablity
    r = rand
    rated_of_probablity.each do |p|
        return p[:rating] if r < p[:probablity]
    end
end

def by_rating arr, rating
  arr.select{ |el| el[:rating] == rating }
end

result = []
until result.size == 3 do
  rating = get_rating rated_of_probablity
  mov = by_rating(movie, rating).sample[:title]
  result << mov unless result.include? mov
end
p result
