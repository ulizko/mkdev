require 'date'
require_relative 'recommendation.rb'
class Movie
  include Recommendation
 
  MIN_RATING = 8
  CONVERTERS = {duration: lambda { |v| v.to_i }, year: lambda { |v| v.to_i }, 
                genre: lambda { |v| v.split(",") }, director: lambda { |v| v },
                rating: lambda { |v| v.to_f }, url: lambda { |v| v },
                title: lambda { |v| v }, country: lambda { |v| v },
                actors: lambda { |v| v.split(",").combination(1).to_a },
                release: lambda { |v| v }
                }
  
  attr_accessor :url, :title, :year, :country, :release, :genre, :duration,
                 :rating, :director, :actors, :weight
  
  def initialize(fields)
    fields.each do |k, v| 
      instance_variable_set("@#{k}", (CONVERTERS[k].call(v)))
    end
    instance_variable_set("@weight", self.class.instance_variable_get("@weight"))
  end

  def to_s
    "%s is directed by %s in %s, played a starring %s, 
    Genre: %s, %d minutes duration. The film premiered in %s. Country: %s. Rating: %s" % [title, 
    director, year, actors.join(", "), genre.join(", "), duration, release, country, stars(rating)]
  end
  
  def stars(rating)
    rating_star = ((rating - MIN_RATING)*10).to_i
    "".ljust(rating_star, "*")
  end
  
  def director_surname
    self.director.split(" ").last
  end
  
  def month_name
    str = self.release
    month = Date.strptime(str, '%Y-%m-%d').mon 
    Date::MONTHNAMES[month]
  end
  
  def self.weight(weight)
    @weight = weight
  end
  
  def self.year
    @year
  end
  
  def instance_variables_hash
    hash_var = self.instance_variables.reduce({}) do |hash, var| 
      hash[var[1..-1].to_sym] = instance_variable_get(var)
      hash
    end
    hash_var[:actors] = actors.flatten.join(", ")
    hash_var
  end
  
  def self.print_format(str)
    class_eval("def to_s; \"#{str}\" %self.instance_variables_hash; end")
  end
  
  def self.filter(&blk)
    @@filters ||= {}
    @@filters[self] = blk
  end
  
  def Movie.create(fields)
    type_movie = @@filters.reduce([]) do |ary, (name, block)| 
      name.instance_variable_set("@year", fields[:year].to_i)
      ary << name if block.call
      ary
    end
    type_movie.first.new(fields)
  end
  
  def method_missing(method_name)
    genre.include? method_name[0..-2].capitalize
  end
  
end
