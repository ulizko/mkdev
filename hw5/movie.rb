require 'date'
class Movie
  
  MIN_RATING = 8
  @@url, @@title, @@year, @@country, @@release, @@genres, @@duration, 
  @@rating, @@director, @@actors = [], [], [], [], [], [], [], [], [], []

  attr_accessor :url, :title, :year, :country, 
                :release, :genres, :duration, 
                :rating, :director, :actors 
  @@converters = {duration: '{ |v| v.to_i }', actors: '{ |v| v.split(",") }',
                  year: '{ |v| v.to_i }', genres: '{ |v| v.split(",") }', 
                  rating: '{ |v| v.to_f }'
                  }
  
  def initialize(fields)
    #@duration = eval "converter('140 m') + str" , get_binding("#{converters[:duration]}")
    fields.each do |k, v| 
      instance_variable_set("@#{k}", (eval "converter(v) #{@@converters[k]}"))
      eval "@@#{k}.push self.#{k}"
    end
    
  end

  def to_s
    "%s is directed by %s in %s, played a starring %s, 
    Genre: %s, %d minutes duration. The film premiered in %s. Rating: %s" % [title, director,
    year, starring.join(", "), genres.join(", "), duration, release, stars(rating)]
  end
  
  def stars(rating)
    rating_star = ((rating - MIN_RATING)*10).to_i
    "".ljust(rating_star, "*")
  end
  
  def director_surname
    self.director.split(" ").last
  end
  
  def month_name(str)
    month = Date.strptime(str, '%Y-%m-%d').mon 
    Date::MONTHNAMES[month]
  end
  
#def get_binding(str)
#return binding
#end
  private
  
  def method_missing(method)
    self.send(method)
  end
=begin
  def self.title
    @@title
  end
  
  def self.director
    @@director
  end
  
  def self.country
    @@country
  end
  
  def self.actors
    @@actors
  end
  
  def self.converters
    @@converters
  end
  def converter(field)
    if block_given?
      yield field
    else
      field
    end
  end
=end
end
