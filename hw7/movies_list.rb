require_relative 'movie.rb'
class MoviesList

  FIELDS = [:url, :title, :year, :country, :release, :genre, :duration, :rating, :director, :actors]
  
  def initialize(file_name)
    @movies_list = File.read(file_name).split("\n").map { |v| Movie.new(FIELDS.zip(v.split("|")).to_h) }
    @filters = Hash.new
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
  
  def print
    if block_given?
      @movies_list.each{ |v|  puts yield v } 
    else
      puts "Please, call method with block"
    end
  end
  
  def sorted_by 
    if block_given?
      @movies_list.sort_by{ |v|  yield v, v }
    else
      puts "Please, call method with block"
    end
  end
  
  def add_sort_algo(fields)
    fields =  Proc.new
    self.sorted_by(&fields)
  end
  
  def add_filter(filter)
    @filters.store(filter, Proc.new)
  end
  
  def filter(filter_name)
    @movies_list.select do |movie|
      filter_name.all? do |key, val|
        case @filters[key].arity
        when 3
          @filters[key].call(movie, *val)
        else
          @filters[key].call(movie, val)
        end
      end
    end
  end
end


list = MoviesList.new('../movies.txt')
list.print { |movie| "#{movie.year}: #{movie.title}" }
list.sorted_by { |movie| [movie.genre, movie.year] }
list.add_sort_algo(:genres_years) { |movie| [movie.genre, movie.year] }

list.add_filter(:duration_greater){|movie, min| movie.duration > min}
list.add_filter(:genres){|movie, *genres| genres.include?(movie.genre)}
list.add_filter(:years){|movie, from, to| (from..to).include?(movie.year)}
n = list.filter(
  genres: ['Crime', 'Thriller'],
  years: [2000, 2010],
  duration_greater: 90
  )
