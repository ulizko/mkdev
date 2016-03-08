require_relative 'movie.rb'
class MoviesList

  FIELDS = [:url, :title, :year, :country, :release, :genres, :duration, :rating, :director, :actors]
  
  def initialize(file_name)
    @movies_list = File.read(file_name).split("\n").map { |v| Movie.new(FIELDS.zip(v.split("|")).to_h) }
  end
  
  def sort_by_field(field)
    @movies_list.sort_by{ |v| v.send(field) }
  end
  
  def filter_by_field(field)
    Movie.send(field).flatten.uniq
  end
  
  def search_by_field(field, str)
    @movies_list.select{ |v| v.send(field).include? str }
  end
  
  def group_by_field(field)
    @movies_list.group_by{|v| v.send(field) }.each{ |_, v| v.map!{ |h| h.title }}
  end
  
  def exclude_by(field, str)
    @movies_list.reject { |v| v.send(field).include? str }
  end

  def count_by(field)
    group_by_field(field).reduce({}){ |tmp, (k, v)| tmp[k] = v.size; tmp }
  end
  
  def count_by_actor
    Movie.actors.flatten.reduce({}) do |hash, k| 
      hash[k] = Movie.actors.flatten.count(k)
      hash
    end
  end
  
  def print_movie(list)
    list.each{ |v| puts v.to_s }
  end
end
