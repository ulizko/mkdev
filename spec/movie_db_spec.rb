require 'bundler/setup'
require 'rspec/its'
require_relative '../lib/movie_db.rb'

RSpec.describe MovieDB do
  
  let(:movie) { MovieDB.new("tt0111161") }
  subject { movie }
  
  its(:titles) {is_expected.to eq("The Shawshank Redemption")}
  its(:year) {is_expected.to eq(1994)}
  its(:country) {is_expected.to eq(["United States of America"])}
  its(:release) {is_expected.to eq("1994-09-10")}
  its(:genre) {is_expected.to eq(["Crime", "Drama"])}
  its(:duration) {is_expected.to eq(142)}
  its(:rating) {is_expected.to eq(8.3)}
  its(:director) {is_expected.to eq("Frank Darabont")}
  its(:actors) {is_expected.to eq(["Tim Robbins", "Morgan Freeman", "Bob Gunton"])}
  
  context "IMDB top-250" do
    subject {MovieDB.build }
    
    its(:size) {is_expected.to eq(250)}
  end
end