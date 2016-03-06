require_relative 'movie.rb'
class MoviesList

  FIELDS = [:url, :title, :year, :country, :release, :genres, :time, :rating, :director, :starring]
  
  def initialize(file_name)
    @movies_list = File.read(file_name).split("\n").map {|v| Movie.new(FIELDS.zip(v.split("|")).to_h)}
  end
  
  def sort_by_field(field, reversed = false)
    sorted = @movies_list.sort_by do |v| 
      case field
      when :title, :country, :release, :genres, :starring
        v.send(field)
      when :year, :time
        v.send(field).to_f
      when :director
        v.send(field).split(" ").last
      end
    end
    reversed ? sorted.reverse : sorted
  end
end
