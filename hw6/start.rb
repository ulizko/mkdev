require_relative 'ancient_movie.rb'
require_relative 'classic_movie.rb'
require_relative 'modern_movie.rb'
require_relative 'new_movie.rb'
require_relative 'movies_list.rb'
require_relative 'ratingable.rb'
require_relative 'my_movies_list.rb'
include Ratingable

m = MyMoviesList.new('../movies.txt')

unwatched = m.search_by_field(:time_watch, nil)
list_on_evening = m.get_recommendation(unwatched)
p "List of unwatched movies on evening"
m.print_movie(list_on_evening)

watched = m.exclude_by(:time_watch, nil)
list_on_evening = m.get_recommendation_watch(watched)
p "List of watched movies on evening"
m.print_movie(list_on_evening)
