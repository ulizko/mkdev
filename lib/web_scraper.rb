require 'mechanize'
require 'json'

mechanize = Mechanize.new

mechanize.history_added = Proc.new { sleep 0.5 }
page = mechanize.get('http://www.imdb.com/chart/top')
links = page.links_with(:href => /^\/title.+/).delete_if { |link| link.text == " \n" }
movies = links.map do |link| 
  movie = link.click
  url = movie.uri.to_s.sub(/(?<=[?]).+(?<=[&])/, "")
  title = link.to_s
  year = movie.css('h1 a').text
  country = movie.links_with(:href => /^\/country.+/)[0].text
  release = movie.css("meta[itemprop='datePublished']")[0].attributes['content'].value
  genre = movie.css("div[itemprop='genre'] a").text.strip.gsub(" ", ",")
  duration = movie.css(".txt-block time[itemprop='duration']")[0].text
  rating = movie.css("span[itemprop='ratingValue']").text
  director = movie.css("span[itemprop='director']").text.strip.sub(/[,()].+/, "").strip
  actors = movie.css("span[itemprop='actors']").text.split(",").map(&:strip).join(",")
  {
    url: url, 
    title: title, 
    year: year, 
    country: country, 
    release: release, 
    genre: genre, 
    duration: duration, 
    rating: rating, 
    director: director, 
    actors: actors
    }
end

puts JSON.pretty_generate(movies)


