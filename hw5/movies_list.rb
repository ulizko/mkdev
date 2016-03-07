require_relative 'movie.rb'
class MoviesList

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
  
  def group_by_field(field)
    @movies_list.group_by{ |v| v.send(field) }
  end
  
  def print_movie(list)
    list.each{|v| puts v.to_s }
  end
end
