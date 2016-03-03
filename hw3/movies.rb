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
  filtred.values
end

def sort_movies(arr, field, reversed = false)
  sorted = arr.sort_by do |key, value|
    value[field].to_f.zero? ? value[field] : value[field].to_f
  end
  reversed ? sorted.reverse : sorted
end

def present_rating_as_stars(arr)
  arr.map do |value|
    rating = ((value[:rating].to_f.ceil - value[:rating].to_f)*10).to_i
    value[:rating] = "".ljust(rating, "*")
  end
  arr
end

s = present_rating_as_stars(search(movies, :title, "Time"))
s.each do |value|
  puts "#{value[:title]} #{value[:rating]}"
end
#puts sort_movies(movies, :country).first(5)