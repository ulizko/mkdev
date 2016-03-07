require_relative 'movie.rb'
class MoviesList
  include Enumerable

  FIELDS = [:url, :title, :year, :country, :release, :genres, :duration, :rating, :director, :starring]
  
  def initialize(file_name)
    @movies_list = File.read(file_name).split("\n").map { |v| Movie.new(FIELDS.zip(v.split("|")).to_h) }
  end
  
  def sort_by_field(field, reversed = false)
    sorted = @movies_list.sort_by do |v| 
      case field
      when :title, :country, :release, :genres, :starring
        v.send(field)
      when :year, :duration
        v.send(field).to_f
      when :director
        v.send(field).split(" ").last
      end
    end
    reversed ? sorted.reverse : sorted
  end
  
  def view(field, str = nil, except = false)
    viewed = if str.nil? 
      self.sort_by_field(field).uniq{ |v| v.send(field) }.select { |v| v.send(field) }
    else
      @movies_list.select { |v| v.send(field).include? str }
    end
    except ? @movies_list - viewed : viewed
  end
  
  def group_by_field(field, count = false)
    movies = @movies_list.clone
    if field == :starring
      actors = movies.map {|v| v.starring = v.starring.split(",")}.flatten.uniq
      group = movies.group_by{|v| v.title}.each{ |_, v| v.map!{ |h| h.starring}}.to_h
      grouped = actors.reduce({}) do |hash, actor|
        group.each do |key, val|
          if hash[actor].nil?
            hash.store(actor, key.split("  ")) if val.flatten.include? actor
          else
            hash[actor] << key if val.flatten.include? actor
          end
        end
        hash
      end
    else
      grouped = movies.group_by{|v| v.send(field) }.each{ |_, v| v.map!{ |h| h.title }}
    end
    count ? grouped.reduce({}){ |tmp, (k, v)| tmp[k] = v.size; tmp} : grouped
  end
  
  def print_movie(list)
    list.each{|v| puts v.to_s }
  end
end
