require_relative 'movie.rb'
class MoviesList

  FIELDS = [:url, :title, :year, :country, :release, :genre, :duration, :rating, :director, :actors]
  attr_reader :movies_list
  
  def initialize(file_name)
    @movies_list = File.read(file_name).split("\n").map { |v| Movie.new(FIELDS.zip(v.split("|")).to_h) }
    @filters, @sorters = {}, {}
  end
  
  def sort_by_field(field)
    @movies_list.sort_by{ |v| v.send(field) }
  end
  
  def filter_by_field(field)
    @movies_list.map{|v| v.send(field)}.flatten.uniq
  end
  
  def search_by_field(field, str)
    @movies_list.select{ |v| v.send(field).include? str }
  end
  
  def group_by_field(field)
    @movies_list.group_by{|v| v.send(field) }.each{ |_, v| v.map!{ |h| h.title }}
  end
  
  def group_by_actor
    @movies_list.map{|m| m.actors.map{|a| [m.title, a]} }.
      flatten(1).group_by(&:last).
      each{|_, v| v.map!(&:first)}
  end
  
  def exclude_by(field, str)
    @movies_list.reject { |v| v.send(field) == str }
  end

  def count_by(field)
    group_by_field(field).reduce({}){ |tmp, (k, v)| tmp[k] = v.size; tmp }
  end
  
  def count_by_actor
    actor_list = @movies_list.map{ |v| v.actors }.flatten 
    actor_list.reduce({}) do |hash, k| 
      hash[k] = actor_list.count(k)
      hash
    end
  end
  
  def print_movie(list)
    list.each{ |v| puts v.to_s }
  end
  
  def print(&blk)
    blk ||= proc { |v|  v.to_s }
    @movies_list.each{ |v| puts blk.call(v) }
  end
  
  def sorted_by(sorter = nil, &blk)
    blk ||= proc { |v| @sorters[sorter].call(v) }
    @movies_list.sort_by(&blk)
  end
  
  def add_sort_algo(fields)
    @sorters.store(fields, Proc.new)
  end
  
  def add_filter(filter)
    @filters.store(filter, Proc.new)
  end
  
  def filter(filter_name)
    filter_name.reduce(movies_list) do |acc, (key, val)|
      acc.keep_if { |movie| @filters[key].arity > 2 ? @filters[key]
      .call(movie, *val) : @filters[key].call(movie, val) }
      acc
    end
  end
  
end


list = MoviesList.new('../movies.txt')
list.print { |movie| "#{movie.year}: #{movie.title}" }
list.sorted_by { |movie| [movie.genre, movie.year] }
list.add_sort_algo(:genres_years) { |movie| [movie.genre, movie.year] }
list.sorted_by(:genres_years)


list.add_filter(:duration_greater){|movie, min| movie.duration > min}
list.add_filter(:genres){|movie, *genres| genres.include?(movie.genre)}
list.add_filter(:years){|movie, from, to| (from..to).include?(movie.year)}
list.filter(
  genres: ['Crime', 'Drama'],
  years: [1960, 2010],
  duration_greater: 90
  )
