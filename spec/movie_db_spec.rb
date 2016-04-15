require 'bundler/setup'
require 'rspec/its'
require_relative '../lib/movie_db.rb'

RSpec.describe MovieDB do
  
  let(:movie) { MovieDB.new(278) }
  subject { movie }
  
  it 'should be Tmdb::Movie' do
    expect(subject.instance_variable_get('@detail')).to be_a(Tmdb::Movie)
  end
  
  its(:title) {is_expected.to eq("The Shawshank Redemption")}
  its(:year) {is_expected.to eq(1994)}
  its(:country) {is_expected.to eq(["United States of America"])}
  its(:release) {is_expected.to eq("1994-09-10")}
  its(:genre) {is_expected.to eq(["Crime", "Drama"])}
  its(:duration) {is_expected.to eq(142)}
  its(:rating) {is_expected.to eq(8.3)}
  its(:director) {is_expected.to eq("Frank Darabont")}
  its(:actors) {is_expected.to eq(["Tim Robbins", "Morgan Freeman", "Bob Gunton"])}
  
  context "top-240" do
    subject {MovieDB.build }
    
    its(:size) {is_expected.to eq(240)}
  end
end