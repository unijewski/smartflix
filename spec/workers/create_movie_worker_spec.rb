# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreateMovieWorker do
  describe '#perform' do
    subject { described_class.new.perform('whatever') }

    let(:service) { instance_double('Movies::Create') }

    it 'calls Movies::Create service' do
      allow(Movies::Create).to receive(:new).with(title: 'whatever').and_return(service)
      expect(service).to receive(:call)
      subject
    end
  end
end
