require_relative 'movie.rb'
require_relative 'ratingable.rb'

class ModernMovie < Movie
  include Ratingable
  
  attr_accessor :user_rate, :time_watch, :weight
  
  def initialize(fields, user_rate = nil, time_watch = nil)
    super(fields)
    @user_rate, @time_watch = user_rate, time_watch
    @weight = 4
  end
  
  def to_s
    "%s - is modern movie, starring %s" % [title, actors.join(", ")]
  end

end