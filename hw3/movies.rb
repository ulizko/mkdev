puts "Hello. Enter file name"
begin
  file_name = gets.chomp
  lines = File.read(file_name).split("\n")
  rescue Exception
  puts "File not found: #{file_name}"
  lines = File.read("movies.txt").split("\n")
  #exit
end

@movies = {}
lines.each do |value|
  value = value.split("|")
  @movies[value[1]] = { url: value[0],
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

def search(str, field = :title)
  filter = @movies.select do |key, value|
    value[field].downcase.include? str.downcase
  end
  filter.each_value do |value|
    rating = ((value[:rating].to_f.ceil - value[:rating].to_f)*10).to_i
    puts "#{value[:title]} #{"".ljust(rating, "*")}"
  end
end

def sort_movies(field, contant = nil, count = 0)
  sorted = @movies.sort_by do |key, value|
    value[field].to_i.zero? ? value[field] : value[field].to_f
  end
  unless count.zero?
    sorted.reverse.first(count).each do |key, value|
      puts "#{key}, #{field.to_s}: #{value[field]}"
    end
  else
    sorted.reverse.each do |key, value|
      puts "#{key}, #{field.to_s}: #{value[field]}"
    end
  end
end


search "God"
sort_movies(:time)