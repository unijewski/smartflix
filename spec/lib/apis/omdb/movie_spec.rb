# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Apis::Omdb::Movie do
  describe '#call' do
    subject { described_class.new(title: title).call }

    context 'when a movie exists' do
      let(:title) { 'The Social Network' }

      around { |example| VCR.use_cassette('omdb_movie_success', &example) }

      it 'returns the proper number of data' do
        expect(subject.size).to eq(25)
      end

      it 'calls the valid endpoint' do
        subject
        expect(
          a_request(:get, 'http://www.omdbapi.com/')
            .with(query: { 'apikey' => Rails.application.credentials.omdb_api_key, 't' => title })
        ).to have_been_made.once
      end
    end

    context 'when a movie does not exist' do
      let(:title) { 'foobar' }

      around { |example| VCR.use_cassette('omdb_movie_failure', &example) }

      it 'returns the proper number of data' do
        expect(subject.size).to eq(2)
      end

      it 'calls the valid endpoint' do
        subject
        expect(
          a_request(:get, 'http://www.omdbapi.com/')
            .with(query: { 'apikey' => Rails.application.credentials.omdb_api_key, 't' => title })
        ).to have_been_made.once
      end
    end
  end
end
