require_relative 'movie.rb'
class MoviesList

  FIELDS = [:url, :title, :year, :country, :release, :genres, :time, :rating, :director, :starring]
  
  def initialize(file_name)
    @movies_list = File.read(file_name).split("\n").map {|v| Movie.new(FIELDS.zip(v.split("|")).to_h)}
  end
  
  def sort_by_field(field)
    @movies_list.sort_by{|v| v.send(field)}
  end
end
