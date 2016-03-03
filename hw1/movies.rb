good_movies = [
  "The Shawshank Redemption", 
  "The Godfather", 
  "The Dark Knight", 
  "Pulp Fiction"
  ]
bad_movies = [
  "Battlefield Earth",
  "Pixels",
  "The Prestige",
  "Bratz"
  ]
  
title = ARGV[0]

if good_movies.include? title
  puts "#{title} is a good movie"
elsif bad_movies.include? title
  puts "#{title} is a bad movie"
else
  puts "Haven't seen #{title} yet"
  
end

=begin

=end
