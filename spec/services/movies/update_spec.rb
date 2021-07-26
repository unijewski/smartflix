# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Movies::Update do
  subject { described_class.new(movie: movie).call }

  context 'when the movie exists on OMDb API' do
    let(:movie) { create(:movie, title: 'The Social Network') }

    around { |example| VCR.use_cassette('omdb_movie_success', &example) }

    it 'returns true' do
      expect(subject).to eq(true)
    end

    it 'updates attributes of the record' do
      expect do
        subject
        movie.reload
      end.to(change(movie, :year).to(2010)
        .and(change(movie, :rated).to('PG-13'))
        .and(change(movie, :released).to(Date.new(2010, 10, 1)))
        .and(change(movie, :runtime).to(120))
        .and(change(movie, :genre).to('Biography, Drama'))
        .and(change(movie, :director).to('David Fincher'))
        .and(change(movie, :writer).to('Aaron Sorkin (screenplay), Ben Mezrich (book)'))
        .and(change(movie, :actors).to('Jesse Eisenberg, Rooney Mara, Bryan Barter, Dustin Fitzsimons'))
        .and(change(movie, :plot).to('As Harvard student Mark Zuckerberg creates the social networking site that would'\
                                     ' become known as Facebook, he is sued by the twins who claimed he stole their '\
                                     'idea, and by the co-founder who was later squeezed out of the business.'))
        .and(change(movie, :language).to('English, French'))
        .and(change(movie, :country).to('USA'))
        .and(change(movie, :awards).to('Won 3 Oscars. Another 169 wins & 186 nominations.'))
        .and(change(movie, :poster).to('https://m.media-amazon.com/images/M/MV5BOGUyZDUxZjEtMmIzMC00MzlmLTg4MGItZWJmM'\
                                       'zBhZjE0Mjc1XkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_SX300.jpg'))
        .and(change(movie, :ratings).to('Internet Movie Database: 7.7/10, Rotten Tomatoes: 96%, and Metacritic: '\
                                        '95/100'))
        .and(change(movie, :metascore).to(95))
        .and(change(movie, :imdb_rating).to(7.7))
        .and(change(movie, :imdb_votes).to(641))
        .and(change(movie, :imdb_id).to('tt1285016'))
        .and(change(movie, :movie_type).to('movie'))
        .and(change(movie, :dvd).to(Date.new(2012, 6, 5)))
        .and(change(movie, :box_office).to('$96,962,694'))
        .and(change(movie, :production).to('Scott Rudin Productions, Michael De Luca, Trigger Street Productions'))
        .and(change(movie, :website).to('N/A'))
        .and(not_change(movie, :title)))
    end
  end

  context 'when the movie does not exist on OMDb API' do
    let(:movie) { create(:movie, title: 'foobar') }

    around { |example| VCR.use_cassette('omdb_movie_failure', &example) }

    it 'returns false' do
      expect(subject).to eq(false)
    end

    it 'does not update any attributes' do
      expect do
        subject
        movie.reload
      end.not_to change(movie, :attributes)
    end
  end
end
