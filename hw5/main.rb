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


list1 = movies_list.sort_by_field(:director_surname)
movies_list.print_movie(list1)

puts "*" * 20

list2 = movies_list.count_by_actor
list2.each{ |k, v| puts "#{k} played in #{v} movies" }

puts "*" * 20

list6 = movies_list.count_by(:director)
list6.each{ |k, v| puts "#{k} made #{v} movies" }

puts "*" * 20

list7 = movies_list.count_by(:month_name)
list7.each{ |k, v| puts "#{k} released #{v} movies" }

puts "*" * 20

list3 = movies_list.filter_by_field(:director)
list3.each{ |v| puts v}

puts "*" * 20

list4 = movies_list.search_by_field(:country, "USA")
movies_list.print_movie(list4)

puts "*" * 20

list8 = movies_list.exclude_by(:country, "USA")
movies_list.print_movie(list8)