# require 'spec_helper.rb'
require_relative '../lib/movie.rb'
require_relative '../lib/modern_movie.rb'
require_relative '../lib/ancient_movie.rb'
require_relative '../lib/classic_movie.rb'
require_relative '../lib/new_movie.rb'

RSpec.describe Movie do
  
  before(:all) do
    @movie = Movie.new({
                      url: "http://www.imdb.com/title/tt0071562/?ref_=chttp_tt_3",
                      title: "The Godfather: Part II",
                      year: "1974",
                      country: "USA",
                      release: "1974-12-20",
                      genre: "Crime,Drama",
                      duration: "202 min",
                      rating: "9.0",
                      director: "Francis Ford Coppola",
                      actors: "Al Pacino,Robert De Niro,Robert Duvall"
                      })
  end
  it 'instance is class Movie' do
    expect(@movie).to be_an_instance_of Movie
  end
  it 'should have 10 instance variables' do
    expect(@movie.instance_variables.size).to eq 10
  end
  it 'year should be Fixnum' do
    expect(@movie.year).to be_a Fixnum
  end
  it 'genre should be ["Crime", "Drama"]' do
    expect(@movie.genre).to eq ["Crime", "Drama"]
  end
  it 'actors should be [["Al Pacino"], ["Robert De Niro"], ["Robert Duvall"]]' do
    expect(@movie.actors).to eq [["Al Pacino"], ["Robert De Niro"], ["Robert Duvall"]]
  end
  it 'duration should be Fixnum' do
    expect(@movie.duration).to be_a Fixnum
  end
  it 'rating should be Float' do
    expect(@movie.rating).to be_a Float
  end
  it 'should be surname by director' do
    expect(@movie.director_surname).to eq "Coppola"
  end
  it 'should be month name by release' do
    expect(@movie.month_name).to eq "December"
  end
  it 'should presents rating as stars' do
    expect(@movie.stars(@movie.rating)).to eq "**********"
  end
  
  context 'inherited classes' do
    def movie(params = {}) 
      defaults = { url: "http://www.imdb.com/title/tt0071562/?ref_=chttp_tt_3",
                   title: "The Godfather: Part II",
                   year: "1974",
                   country: "USA",
                   release: "1974-12-20",
                   genre: "Crime,Drama",
                   duration: "202 min",
                   rating: "9.0",
                   director: "Francis Ford Coppola",
                   actors: "Al Pacino,Robert De Niro,Robert Duvall"
                   }
      Movie.create(**defaults.merge(params))
    end
    
    it { expect(movie).to be_an_instance_of ModernMovie }
    it { expect(movie(year: "1950")).to be_an_instance_of ClassicMovie }
    it { expect(movie(year: "1930")).to be_an_instance_of AncientMovie }
    it { expect(movie(year: "2012")).to be_an_instance_of NewMovie }
    context "user rating movie" do
      before(:all) {
        @movie = movie
      }
    
      it 'user_rate should be nil' do
        expect(@movie.user_rate).to be_nil
      end
      
      it 'time_watch should be nil' do
        expect(@movie.time_watch).to be_nil
      end
      
      context ".rate" do
        it "should set user rating" do
          @movie.rate(3)
          expect(@movie.user_rate).to eq 3
        end
      end
    end
    
    describe "#print_format" do
      it 'presents format as "The Godfather: Part II - is modern movie, starring: Al Pacino, Robert De Niro, Robert Duvall"' do
        expect(movie.to_s).to eq "The Godfather: Part II - is modern movie, starring: Al Pacino, Robert De Niro, Robert Duvall"
      end
    end
  end
end