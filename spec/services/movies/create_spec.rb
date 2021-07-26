# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Movies::Create do
  subject { described_class.new(title: title).call }

  context 'when a movie exists' do
    let(:title) { 'The Social Network' }

    around { |example| VCR.use_cassette('omdb_movie_success', &example) }

    it 'creates a Movie record' do
      expect { subject }.to change(Movie, :count).by(1)
    end

    it 'sets proper attributes for the record' do
      subject
      expect(Movie.last).to have_attributes(
        title: 'The Social Network',
        year: 2010,
        rated: 'PG-13',
        released: Date.new(2010, 10, 1),
        runtime: 120,
        genre: 'Biography, Drama',
        director: 'David Fincher',
        writer: 'Aaron Sorkin (screenplay), Ben Mezrich (book)',
        actors: 'Jesse Eisenberg, Rooney Mara, Bryan Barter, Dustin Fitzsimons',
        plot: 'As Harvard student Mark Zuckerberg creates the social networking site that would become known as '\
              'Facebook, he is sued by the twins who claimed he stole their idea, and by the co-founder who was later '\
              'squeezed out of the business.',
        language: 'English, French',
        country: 'USA',
        awards: 'Won 3 Oscars. Another 169 wins & 186 nominations.',
        poster: 'https://m.media-amazon.com/images/M/MV5BOGUyZDUxZjEtMmIzMC00MzlmLTg4MGItZWJmMzBhZjE0Mjc1XkEyXkFqcGde'\
                'QXVyMTMxODk2OTU@._V1_SX300.jpg',
        ratings: 'Internet Movie Database: 7.7/10, Rotten Tomatoes: 96%, and Metacritic: 95/100',
        metascore: 95,
        imdb_rating: 7.7,
        imdb_votes: 641,
        imdb_id: 'tt1285016',
        movie_type: 'movie',
        dvd: Date.new(2012, 6, 5),
        box_office: '$96,962,694',
        production: 'Scott Rudin Productions, Michael De Luca, Trigger Street Productions',
        website: 'N/A'
      )
    end
  end

  context 'when a movie does not exist' do
    let(:title) { 'foobar' }

    around { |example| VCR.use_cassette('omdb_movie_failure', &example) }

    it 'does not create a Movie record' do
      expect { subject }.not_to change(Movie, :count)
    end

    it 'logs a warning' do
      travel_to Time.utc(2021, 7, 26, 11, 44)

      expect(Rails.logger).to receive('warn').with('2021-07-26 11:44:00 UTC: foobar movie not found!')
      subject
    end
  end
end
