require 'csv'
require 'date'
require 'ostruct'

FIELDS = [:url, :title, :year, :country, :release, :genres, :time, :rating, :director, :starring]

puts "Hello. Enter file name"
begin
  file_name = gets.chomp
  lines = File.read(file_name).split("\n")
  rescue Exception
  puts "File not found: #{file_name}"
  exit
end

movies_table = CSV.read(file_name, { :col_sep => '|', :headers => FIELDS}) 

arr = movies_table.by_col[:release].delete_if{|s| s.size < 7}.map{|v| Date.strptime(v, '%Y-%m').mon}
mon = arr.reduce({}) do |hash, k|
  hash[Date::MONTHNAMES[k]] = arr.count(k)
  hash
end
mon.sort_by{|k, v| Date.parse(k).mon}.each{|k, v| puts "In #{k} released #{v} movies" }

puts "*" * 20

movies = movies_table.map{|v| OpenStruct.new(v.to_h)}

filter = movies.select {|value| value.title.include? "Time"}

filter.each do |value|
  rating = ((value.rating.to_f.ceil - value.rating.to_f)*10).to_i
  puts "#{value.title} #{"".ljust(rating, "*")}"
end

puts "*" * 20

the_longest_movies = movies.sort_by {|value| value.time.to_f}.reverse!.first(5)
the_longest_movies.each { |value| puts "#{value.title} #{value.time}"}

puts "*" * 20

comedy = movies.select {|value| value[:genres].include? "Comedy"}.sort_by{|value| value.release}
comedy.each {|value| puts "#{value.title} released #{value.release}"}

puts "*" * 20

directors = movies.sort_by{|v| v.director.split(" ").last}.uniq {|v| v.director}
directors.each {|v| puts v.director}

puts "*" * 20

movies_not_usa = movies.count {|v| v.country != "USA"}
p movies_not_usa

puts "*" * 20

group_by_directors = movies.group_by{|val| val.director}
group_by_directors.each do |k, v|
  puts "#{k} made #{v.count} movies"
end

puts "*" * 20

actor = movies.map {|v| v[:starring].split(",")}.flatten
count_actor = actor.reduce({}) do |hash, k| 
    hash[k] = actor.count(k)
    hash
end
count_actor.each {|k, v| puts "#{k} starred in #{v} movies"}

=begin
1. require методб который используется для подключения файлов/библиотек.
2. Опции передаются в виде Hash.
=end
