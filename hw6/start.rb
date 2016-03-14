require_relative 'ancient_movie.rb'
require_relative 'classic_movie.rb'
require_relative 'modern_movie.rb'
require_relative 'new_movie.rb'
require_relative 'movies_list.rb'
require_relative 'recommendation.rb'
require_relative 'my_movies_list.rb'
include Recommendation

m = MyMoviesList.new('../movies.txt')

list_on_evening = m.get_recommendation
p "List of unwatched movies on evening"
m.print_movie(list_on_evening)

list_on_evening = m.get_recommendation_watched
puts "List of watched movies on evening:"
m.print_movie(list_on_evening)
