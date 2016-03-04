FIELDS = [:url, :title, :year, :country, :release, :genres, :time, :rating, :director, :starring]
puts "Hello. Enter file name"
begin
  file_name = gets.chomp
  lines = File.read(file_name).split("\n")
  rescue Exception
  puts "File not found: #{file_name}"
  exit
end

movies = lines.map {|v| FIELDS.zip(v.split("|")).to_h}

filter = movies.select {|value| value[:title].include? "Time"}

filter.each do |value|
  rating = ((value[:rating].to_f.ceil - value[:rating].to_f)*10).to_i
  puts "#{value[:title]} #{"".ljust(rating, "*")}"
end

puts "*" * 20

the_longest_movies = movies.sort_by {|value| value[:time].to_f}.reverse!.first(5)
the_longest_movies.each { |value| puts "#{value[:title]} #{value[:time]}"}

puts "*" * 20

comedy = movies.select {|value| value[:genres].include? "Comedy"}.sort_by{|value| value[:release]}
comedy.each {|value| puts "#{value[:title]} released #{value[:release]}"}

puts "*" * 20

directors = movies.sort_by{|v| v[:director].split(" ").last}.uniq {|v| v[:director]}
directors.each {|v| puts v[:director]}

puts "*" * 20

movies_not_usa = movies.count {|v| v[:country] != "USA"}
p movies_not_usa

puts "*" * 20

group_by_directors = movies.group_by{|val| val[:director]}
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
1. method chaining это написание кода в одну строчку, использование разных методов последовательно в цепочке.
2. map и map! применяют переданный блок к каждому элементу массива и возвращают новый массив,
  который содержит значения возвращаемые блоком.
  reject и reject! возвращают новый массив со значениями для которых выполняется условие переданное в блоке.
  map, reject используют без method chaining, а map!, reject! используют внутри цепочки method chaining
=end