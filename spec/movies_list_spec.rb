# require 'spec_helper.rb'
require_relative '../lib/movie.rb'
require_relative '../lib/movies_list.rb'
require_relative '../lib/recommendation.rb'

RSpec.describe MoviesList do
  before(:all) do
    @list = MoviesList.new("./movies.1.txt")
  end
  
   it 'instance is class MoviesList' do
    expect(@list).to be_an_instance_of MoviesList
  end
  
  it 'list should be contains 20 objects' do
    expect(@list.movies_list.size).to eq 20
  end
  
  context ".sort_by_field" do
    
    it "should be return first movie " do
      expect(@list.sort_by_field(:duration).first).to have_attributes(:title => "12 Angry Men")
    end
  end
  
  context ".filter_by_field" do
    let (:directors) { ["Frank Darabont", "Francis Ford Coppola", "Christopher Nolan", "Sidney Lumet",
                        "Steven Spielberg", "Quentin Tarantino", "Sergio Leone", "Peter Jackson",
                        "David Fincher", "Irvin Kershner", "Robert Zemeckis", "Milos Forman",
                        "John Huston", "Henri-Georges Clouzot", "Federico Fellini"
                      ] }
    it "should be return uniq directors" do
      expect(@list.filter_by_field(:director).sort == directors.sort).to be_truthy
    end
  end
  
  context ".search_by_field" do
    it "should return movie within Knight" do
      expect(@list.search_by_field(:title, "Knight")).to include(have_attributes(:title => "The Dark Knight"))
    end
  end
  context ".exclude_by" do
    it "should return movie without USA " do
      expect(@list.exclude_by(:country, "USA")).not_to include(have_attributes(:country => "USA"))
    end
  end
  context ".group_by_field" do
    it "should have keys" do
      expect(@list.group_by_field(:country)).to include("USA", "Italy", "France", "New Zealand")
    end
    it "Italy should be size 2" do
      expect(@list.group_by_field(:country)["Italy"].size).to eq 2
    end
  end
  context ".count_by" do
    it "should return count release by month" do
      expect(@list.count_by(:month_name)).to include "December" => 6 
    end
  end
  
  context ".get_recommendation" do
    it "should return default size of list" do
      expect(@list.get_recommendation.size).to eq 5
    end
    it "should return size of list" do
      expect(@list.get_recommendation(7).size).to eq 7
    end
  end
  
  context ".get_recommendation_watched" do
    it "should return size of list" do
      @list.movies_list.first.rate(5)
      expect(@list.get_recommendation_watched.size).to eq 1
    end
  end
  
  context "sorted" do
    context ".sorted_by" do
      it "should " do
        
      end
    end
  end
  
end