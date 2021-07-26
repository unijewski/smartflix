# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UpdateAllMoviesWorker do
  describe '#perform' do
    subject { described_class.new.perform }

    let(:movie) { build_stubbed(:movie) }

    it 'enqueues UpdateMovieWorker' do
      allow(Movie).to receive(:find_each).and_yield(movie)
      expect(UpdateMovieWorker).to receive(:perform_async).with(movie.id)
      subject
    end
  end
end
