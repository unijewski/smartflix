require 'rails_helper'

RSpec.describe Apis::Omdb::Movie do
  describe '#call' do
    subject { described_class.new(title: 'The Social Network').call }

    around { |example| VCR.use_cassette('omdb_movie', &example) }

    it 'returns 200 status' do
      expect(subject.code).to eq(200)
    end

    it 'returns the proper number of data' do
      expect(subject.size).to eq(25)
    end

    it 'calls the valid endpoint' do
      subject
      expect(
        a_request(:get, 'http://www.omdbapi.com/')
          .with(query: { 'apikey' => Rails.application.credentials.omdb_api_key, 't' => 'The Social Network' })
      ).to have_been_made.once
    end
  end
end
