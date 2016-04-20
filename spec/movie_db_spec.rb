require 'bundler/setup'
require 'rspec/its'
require_relative '../lib/movie_db.rb'

RSpec.describe MovieDB do

  context ".new" do
    it "should get movie from API" do
      expect(Tmdb::Movie).to receive(:detail).with(278)
      MovieDB.new(278)
    end
  end
  
  context ".build" do
    let(:dir){ ["name" =>"Frank Darabont"] }
    let(:act){ [
      {"name" =>"Tim Robbins"}, 
      {"name" =>"Morgan Freeman"}, 
      {"name" =>"Bob Gunton"}
      ] }
    let(:movie){ FactoryGirl.create(:movie) }
    
    it "should return list top rated movies" do
      expect(Tmdb::Movie).to receive(:top_rated).exactly(12).times
        .and_return(OpenStruct.new(:results => Array.new(20)))
      result = MovieDB.get_list
    end
    
    it "should return 240 items" do
      expect(Tmdb::Movie).to receive(:director).exactly(240).times
        .and_return(dir)
      expect(Tmdb::Movie).to receive(:cast).exactly(240).times
        .and_return(act)
      expect(Tmdb::Movie).to receive(:detail).exactly(240).times.and_return(movie)
      result = MovieDB.build
      expect(result.size).to eq(240)
      
    end
    
    it "should return movie" do
      expect(Tmdb::Movie).to receive(:director).and_return(dir)
      expect(Tmdb::Movie).to receive(:cast).and_return(act)
      expect(Tmdb::Movie).to receive(:detail).and_return(movie)
      result = MovieDB.new(278)
      expect(result.title).to eq("The Shawshank Redemption")
      expect(result.year).to eq(1994)
      expect(result.release).to eq("1994-10-12")
      expect(result.country).to eq(["USA", "Canada"])
      expect(result.genre).to eq(["Action", "Crime", "Drama"])
      expect(result.actors).to eq(["Tim Robbins", "Morgan Freeman", "Bob Gunton"])
      expect(result.director).to eq("Frank Darabont")
    end
  end
end