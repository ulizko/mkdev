require_relative 'movie.rb'
require_relative 'movies_list.rb'
puts "Hello. Enter file name"
begin
  file_name = gets.chomp
  movies_list = MoviesList.new(file_name)
  rescue Exception
  puts "File not found: #{file_name}"
  exit
end

list = movies_list.view(:genres, "Crime")
movies_list.print_movie(list)


list1 = movies_list.sort_by_field(:year, true)
movies_list.print_movie(list1)

list2 = movies_list.group_by_field(:director, true)
movies_list.print_movie(list2)