require_relative 'movie.rb'
require_relative 'movies_list.rb'
puts "Hello. Enter file name"
begin
  file_name = gets.chomp
  movie_list = MoviesList.new(file_name)
  rescue Exception
  puts "File not found: #{file_name}"
  movie_list = MoviesList.new('movies.txt')
  exit
end
