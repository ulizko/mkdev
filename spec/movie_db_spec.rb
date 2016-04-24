require 'bundler/setup'
require 'rspec/its'
require_relative '../lib/movie_db.rb'

RSpec.describe MovieDB do
  
  describe ".build" do
    let(:page) { VCR.use_cassette("movie/get_page") { MovieDB.get_page(1) } }
    
    let(:tmdb_top) { VCR.use_cassette("tmdb/tmdb_top") { Tmdb::Movie.top_rated(page: 3) } }
    
    let(:list) { VCR.use_cassette("movie/list") { MovieDB.get_list } }
    
    context ".get_page" do
      it "should get page from Tmdb::Movie" do
        expect(page).not_to be_nil
        expect(page.sample).to be_a(Tmdb::Movie)
      end
    end
    
    context ".get_list" do
      it "should get 12 pages" do
        expect(Tmdb::Movie).to receive(:top_rated).exactly(12).times.and_return(tmdb_top)
        MovieDB.get_list
      end
      
      it "list should have size of 240" do
        expect(list.size).to eq(240)
      end
      it "list should be unique" do
        expect(list).to be_uniq
      end
    end
  end
  
  describe ".new" do
    let(:detail) { VCR.use_cassette("movie/detail") { MovieDB.new(278) } }
    
    let(:director) { VCR.use_cassette("tmdb/director") { Tmdb::Movie.director(278) } }
    
    let(:actor) { VCR.use_cassette("tmdb/actor") { Tmdb::Movie.cast(278) } }
    
    subject { detail }
    
    context ".initialize" do
      it "should get movie detail from Tmdb" do
        expect(Tmdb::Movie).to receive(:detail).with(278).once
        MovieDB.new(278)
      end
        
        it { expect(subject.title).to be_a(String) }
        it { expect(subject.release).to be_a(String) }
        it { expect(subject.year).to be_a(Fixnum) }
        it { expect(subject.country).to be_a(Array) }
        it { expect(subject.genre).to be_a(Array) }
        it { expect(subject.duration).to be_a(Fixnum) }
        it { expect(subject.rating).to be_a(Float) }
        it { expect(subject.id).to be_a(Fixnum) }
    end
    
    context "#director" do
      it "should get movie director from Tmdb" do
        expect(Tmdb::Movie).to receive(:director).with(278).once.and_return(director)
        result = subject.director
        expect(result).to be_a(String)
      end
    end
    
    context "#actors" do
      it "should get movie actors from Tmdb" do
        expect(Tmdb::Movie).to receive(:cast).with(278).once.and_return(actor)
        result = subject.actors
        expect(result).to be_a(Array)
      end
    end
  end
end