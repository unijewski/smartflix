# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UpdateMovieWorker do
  describe '#perform' do
    subject { described_class.new.perform(movie.id) }

    let(:movie) { build_stubbed(:movie) }
    let(:service) { instance_double('Movies::Update') }

    it 'calls Movies::Update service' do
      allow(Movie).to receive(:find).with(movie.id).and_return(movie)
      allow(Movies::Update).to receive(:new).with(movie: movie).and_return(service)

      expect(service).to receive(:call)
      subject
    end
  end
end
