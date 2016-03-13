require_relative 'ancient_movie.rb'
require_relative 'classic_movie.rb'
require_relative 'modern_movie.rb'
require_relative 'new_movie.rb'
require_relative 'movies_list.rb'
require_relative 'ratingable.rb'

class MyMoviesList < MoviesList
  include Ratingable
  
  attr_accessor :movies_list
  
  WEIGHT = {ancient_movie: 1, classic_movie: 3, modern_movie: 4, new_movie: 5 }
  
  def initialize(file_name)
    movies_hash = File.read(file_name).split("\n").map do |v| 
      FIELDS.zip(v.split("|")).to_h
    end
    @movies_list = movies_hash.map do |line|
      case line[:year].to_i
      when (1900...1945)
        AncientMovie.new(line, WEIGHT[:ancient_movie], rand(0..5))
      when (1945...1968)
        ClassicMovie.new(line, WEIGHT[:classic_movie], rand(0..5))
      when (1968...2000)
        ModernMovie.new(line, WEIGHT[:modern_movie], rand(0..5))
      else
        NewMovie.new(line, WEIGHT[:new_movie], rand(0..5), Time.now)
      end
    end
  end
  
  def search_by_field(field, str)
    @movies_list.select{ |v| v.send(field) == str }
  end
  
  def value_variable_get
    instance = self.instance_variables.first
    self.instance_variable_get(instance)
  end 
  
  def probabilities (field)
    sum = self.value_variable_get.map { |v| converter(v.send(field)) }.uniq.reduce(:+)
    probability = 0.0
    probability_for = self.value_variable_get.map{ |v| converter(v.send(field)) }.uniq.sort.map do |el|
      current = (el / sum).round(3)
      probability += current
      eval "{ #{field}: #{el}, probability: #{probability}}"
    end
    probability_for
  end
  
  def movie_probability(*field)
      movie_probability = self.value_variable_get.map do |m|
        probability_1 = probabilities(field.first).select{ |val| val[field.first] == m.send(field.first)}.map{ |v| v[:probability]}.first
        probability_2 = probabilities(field.last).select{ |val| val[field.last] == m.send(field.last)}.map{ |v| v[:probability]}.first
        sum_probability = (probability_1 * probability_2).round(4)
        {title: m.title, probability: sum_probability}
      end
      movie_probability.sort_by{ |v| v[:probability] }
  end
  
  def get_value(probabilities)
    r = rand
    probabilities.each{ |prob| return prob[:title] if r < prob[:probability] }
  end
  
  def get_movie(list, criterion)
    list.select{ |v| v.title == criterion}.join
  end
  
  def get_recommendation(*field)
    result = []
    until result.size == 5 do
      criterion = get_value(movie_probability(field.first, field.last))
      mov = get_movie(self.value_variable_get, criterion)
      result << mov unless mov.empty? || result.include?(mov)
    end
    result
  end
  
  def converter(value)
    return Time.now.to_f - value.to_f if value.is_a? Time
    value.to_f
  end
  
end