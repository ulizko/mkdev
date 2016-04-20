require 'ostruct'
FactoryGirl.define do
  factory :movie, class: Tmdb::Movie do |m|
    title "The Shawshank Redemption"
    production_countries { [{"name" => "USA"}, {"name" =>"Canada"}] }
    release_date "1994-10-12"
    genres { [{"name" =>"Drama"}, {"name" => "Crime"}, {"name" => "Action"}] }
    runtime 120
    vote_average 6.8
    
      # m.sequence(:title) { "The Shawshank Redemption"}
      # m.sequence(:production_countries) { [{"name" => "USA"}, {"name" =>"Canada"}, {"name" =>"Ireland"}, {"name" =>"France"}, 
      #   {"name" =>"Italy"}, {"name" =>"Japan"}].sample(rand(1..3)) }
      # m.sequence(:release_date) { "#{rand(1920..2016)}-#{rand(1..12)}-#{rand(1..28)}" }
      # m.sequence(:genres) { [{"name" =>"Drama"}, {"name" => "Crime"}, {"name" => "Action"},
      #   {"name" => "Adventure"}, {"name" => "Horror"}].sample(rand(1..3))} 
      # m.sequence(:runtime) { rand(90..230) }
      # m.sequence(:vote_average) { rand(8.0..10.0).round(1) }
      # director { {"name" =>"Frank Darabont"}} 
      # actors {[["name" =>"Tim Robbins"], ["name" =>"Morgan Freeman"], ["name" =>"Bob Gunton"],
      #       ["name" =>"William Sadler"], ["name" =>"Clancy Brown"]]}
    
  end
end