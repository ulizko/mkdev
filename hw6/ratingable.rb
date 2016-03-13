module Ratingable
  include Enumerable
  
  def value_variable_get
    instance = self.instance_variables.first
    self.instance_variable_get(instance)
  end
  
  
  def view
    puts "Ratingable"
  end
  
  def self.extended(base)
    puts "Class #{base} hello from #{self}"
  end
  
  def sum(fields)
    Object.map{ |v| v.send(fields) }
  end
  
end