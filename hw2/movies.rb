puts "Hello. Enter file name"
begin
  file_name = gets.chomp
  lines = File.read(file_name).split("\n")
  rescue Exception
  puts "File not found: #{file_name}"
  exit
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
  filter.each do |key, value|
    rating = ((value[:rating].to_f.ceil - value[:rating].to_f)*10).to_i
    puts "#{value[:title]} #{"".ljust(rating, "*")}"
  end
end

search "God"
