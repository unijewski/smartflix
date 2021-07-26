# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Apis::Omdb::Builders::Movie do
  describe '#build' do
    subject { described_class.new(data: data).build }

    context 'when the response status equals false' do
      let(:data) do
        {
          'Response' => 'False',
          'Error' => 'Something went wrong'
        }
      end

      it { is_expected.to eq(response: false, error: 'Something went wrong') }
    end

    context 'when the response status equals true' do
      let(:data) do
        {
          'Response' => 'True',
          'imdbRating' => '7.5',
          'Type' => 'Movie',
          'Ratings' => [
            { 'Source' => 'Internet Movie Database', 'Value' => '7.7/10' },
            { 'Source' => 'Rotten Tomatoes', 'Value' => '96%' }
          ]
        }
      end

      it do
        expect(subject).to eq(
          response: true,
          imdb_rating: '7.5',
          movie_type: 'Movie',
          ratings: 'Internet Movie Database: 7.7/10 and Rotten Tomatoes: 96%'
        )
      end
    end
  end
end
