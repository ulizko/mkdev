require_relative 'ancient_movie.rb'
require_relative 'classic_movie.rb'
require_relative 'modern_movie.rb'
require_relative 'new_movie.rb'
require_relative 'movies_list.rb'
require_relative 'ratingable.rb'
require_relative 'my_movies_list.rb'
include Ratingable


m = MyMoviesList.new('movies.txt')

watched = m.exclude_by(:time_watch, 0)
list_on_evening = m.get_recommendation(watched, :user_rate, :time_watch)
p "List of watched movies on evening"
m.print_movie(list_on_evening)

unwatched = m.search_by_field(:time_watch, 0)
list_on_evening = m.get_recommendation(unwatched, :rating, :weight)
p "List of unwatched movies on evening"
m.print_movie(list_on_evening)
