puts "Hello. Enter file name"
begin
  file_name = gets.chomp
  lines = File.read(file_name).split("\n")
  rescue Exception
  puts "File not found: #{file_name}"
  lines = File.read("movies.txt").split("\n")
  #exit
end

movies = {}
lines.each do |value|
  value = value.split("|")
  movies[value[1]] = { url: value[0],
                       title: value[1],
                       year: value[2],
                       country: value[3],
                       release: value[4],
                       genres: value[5],
                       time: value[6],
                       rating: value[7],
                       director: value[8],
                       starring: value[9]
                      }
end

def search(arr, field, str)
  filtred = arr.select do |_, value|
    value[field].downcase.include? str.downcase
  end
  filtred
end

def sort_movies(arr, field, reversed = false)
  sorted = arr.sort_by do |_, value|
    case field
    when :title, :country, :release, :genres, :starring
      value[field]
    when :year, :time
      value[field].to_f
    when :director
      value[field].split(" ").last
    end
  end
  reversed ? sorted.reverse : sorted
end

def present_rating_as_stars(arr)
  arr.map do |_, value|
    rating = ((value[:rating].to_f.ceil - value[:rating].to_f)*10).to_i
    value[:rating] = "".ljust(rating, "*")
  end
  arr
end

def slice_movies(arr, *option)
  arr.values.map! do |v|
     v.select {|k, _| option.include? k}
  end
end

def count_actor(arr)
  hash = arr.group_by{|val| val[:title]}.each{|_, v| v.map!{|m| m[:starring].split(",")}.flatten!}
  cnt = hash.values.flatten.reduce({}) do |tmp, k|
    tmp[k] = hash.values.flatten.count(k)
    tmp
  end
  cnt.sort_by {|v, k| k}.to_h
end


stars = present_rating_as_stars(search(movies, :title, "Time"))
stars.each do |_, value|
  puts "#{value[:title]} #{value[:rating]}"
end

20.times{ print "*"}
p 

the_longest_movies = sort_movies(movies, :time, true).first(5)
the_longest_movies.each do |_, value| 
  puts "#{value[:title]} #{value[:time]}"
end

20.times{ print "*"}
p 

comedy = sort_movies(search(movies, :genres, "Comedy"), :release)
comedy.each do |_, value|
  puts "#{value[:title]} #{value[:release]}"
end

20.times{ print "*"}
p 

directors = sort_movies(movies, :director).uniq {|_, v| v[:director]}
directors.each do |_, value|
  puts value[:director]
end

20.times{ print "*"}
p 

country_not_usa = movies.count {|_, v| v[:country] != "USA"}
p country_not_usa

20.times{ print "*"}
p 

group_by_directors = movies.values.group_by{|val| val[:director]}.each{|_, v| v.map!{|m| m[:title]}}
count_movies = group_by_directors.values.reduce({}) do |tmp, k|
    tmp[group_by_directors.key(k)] = k.size
    tmp
end
count_movies.each do |k, v|
  puts "#{k} made #{v} movies"
end

20.times{ print "*"} 
p 

count_actor(slice_movies(movies, :title, :starring)).each do |k, v|
  puts "#{k} starred in #{v} movies"
end


=begin
1. method chaining это написание кода в одну строчку, использование разных методов последовательно в цепочке.
2. map и map! применяют переданный блок к каждому элементу массива и возвращают новый массив,
  который содержит значения возвращаемые блоком.
  reject и reject! возвращают новый массив со значениями для которых выполняется условие переданное в блоке.
  map, reject используют без method chaining, а map!, reject! используют внутри цепочки method chaining
=end