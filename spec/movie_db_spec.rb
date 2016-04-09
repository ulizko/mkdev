require_relative '../lib/movie_db.rb'

RSpec.describe MovieDB do
  
  let(:movie) { MovieDB.new("The Shawshank Redemption") }
  
  context "should return" do
    it "title" do
      expect(movie.title).to eq("The Shawshank Redemption")
    end
    it "year" do
      expect(movie.year).to eq(1994)
    end
    it "country" do
      expect(movie.country).to eq(["United States of America"])
    end
    it "release date" do
      expect(movie.release).to eq("1994-09-10")
    end
    it "genres" do
      expect(movie.genre).to eq ["Crime", "Drama"]
    end
    it "duration" do
      expect(movie.duration).to eq(142)
    end
    it "rating" do
      expect(movie.rating).to eq(8.3)
    end
    it "director" do
      expect(movie.director).to eq("Frank Darabont")
    end
    it "actors" do
      expect(movie.actors).to eq(["Tim Robbins", "Morgan Freeman", "Bob Gunton"])
    end
  end
end