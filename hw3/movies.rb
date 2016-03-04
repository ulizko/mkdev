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
  filtred = arr.select do |key, value|
    value[field].downcase.include? str.downcase
  end
  filtred
end

def sort_movies(arr, field, reversed = false)
  sorted = arr.sort_by do |key, value|
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
  arr.map do |key, value|
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



=begin
stars = present_rating_as_stars(search(movies, :title, "Time"))
stars.each do |_, value|
  puts "#{value[:title]} #{value[:rating]}"
end

the_longest_movies = sort_movies(movies, :time, true).first(5)
the_longest_movies.each do |_, value| 
  puts "#{value[:title]} #{value[:time]}"
end

comedy = sort_movies(search(movies, :genres, "Comedy"), :release)
comedy.each do |_, value|
  puts "#{value[:title]} #{value[:release]}"
end

directors = sort_movies(movies, :director).uniq {|_, v| v[:director]}
directors.each do |_, value|
  puts value[:director]
end

country_not_usa = movies.count {|_, v| v[:country] != "USA"}
p country_not_usa


group_by_directors = movies.values.group_by{|val| val[:director]}.each{|_, v| v.map!{|m| m[:title]}}

p group_by_directors

=end
p slice_movies(movies, :title, :starring)
