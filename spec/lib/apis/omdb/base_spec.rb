# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Apis::Omdb::Base do
  describe '#call' do
    subject { dummy_class.new.call }

    let(:dummy_class) { Class.new(described_class) }

    it 'raises an error' do
      expect { subject }.to raise_error(NoMethodError, 'call')
    end
  end
end
