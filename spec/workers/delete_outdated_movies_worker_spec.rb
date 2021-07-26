# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DeleteOutdatedMoviesWorker do
  describe '#perform' do
    subject { described_class.new.perform }

    let(:movies_collection) { instance_double('ActiveRecord::Relation') }

    it 'destroys outdated movies' do
      allow(Movie).to receive(:outdated).and_return(movies_collection)
      expect(movies_collection).to receive(:destroy_all)
      subject
    end
  end
end
