class Movie
  attr_accessor :url, :title, :year, :country, :release, :genres, :duration, :rating, :director, :starring 
  
  def initialize(filds)
    filds.each{ |k, v| instance_variable_set("@#{k}",v) }
  end
  
  def to_s()
    "%s is directed by %s in %s, played a starring %s, 
    Genre: %s, %d minutes duration. The film premiered in %s. Rating: %s" % [title, director,
    year, starring.split(",").join(", "), genres.split(",").join(", "), duration.to_i,
    release, stars(rating)]
  end
  
  def stars(rating)
    rating_star = ((rating.to_f - 8)*10).to_i
    "".ljust(rating_star, "*")
  end
end
