class Movie
  attr_reader :url, :title, :year, :country, :release, :genres, :time, :rating, :director, :starring 
  
  def initialize(filds)
    filds.each{ |k, v| instance_variable_set("@#{k}",v) }
  end
end