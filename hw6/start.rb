require_relative 'ancient_movie.rb'
require_relative 'classic_movie.rb'
require_relative 'modern_movie.rb'
require_relative 'new_movie.rb'
require_relative 'movies_list.rb'
require_relative 'ratingable.rb'
require_relative 'my_movies_list.rb'
include Ratingable


movies_list = MyMoviesList.new('movies.txt')

#movies_list.value_variable_get

unwatched = movies_list.get_recommendation(:rating, :weight)
#watched = movies_list.exclude_by(:time_watch, 0).get_recommendation(:user_rate, :time_watch)
p "List on evening"
movies_list.print_movie(unwatched)
p "*********"
p "List on evening"
movies_list.print_movie(watched)
