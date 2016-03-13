require_relative 'ancient_movie.rb'
require_relative 'classic_movie.rb'
require_relative 'modern_movie.rb'
require_relative 'new_movie.rb'
require_relative 'movies_list.rb'
require_relative 'ratingable.rb'

class MyMoviesList < MoviesList
  include Ratingable
  
  attr_reader :movies_list
  
  def initialize(file_name)
    movies_hash = File.read(file_name).split("\n").map do |v| 
      FIELDS.zip(v.split("|")).to_h
    end
    @movies_list = movies_hash.map do |line|
      case line[:year].to_i
      when (1900...1945)
        AncientMovie.new(line, rand(0..5))
      when (1945...1968)
        ClassicMovie.new(line, rand(0..5))
      when (1968...2000)
        ModernMovie.new(line, rand(0..5))
      else
        r = rand(1400000000..1450000000)
        NewMovie.new(line, rand(0..5), Time.at(r))
      end
    end
  end
  
  def search_by_field(field, str)
    @movies_list.select{ |v| v.send(field) == str }
  end
end