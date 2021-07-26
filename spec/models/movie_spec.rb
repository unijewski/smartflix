# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Movie, type: :model do
  describe 'scopes' do
    describe '.outdated' do
      subject { described_class.outdated }

      let(:movie_1) { create(:movie, updated_at: 2.days.ago) }
      let(:movie_2) { create(:movie, updated_at: 2.days.ago - 1.minute) }
      let(:movie_3) { create(:movie, updated_at: 2.days.ago + 1.minute) }
      let(:movies) { [movie_1, movie_2, movie_3] }

      it do
        freeze_time do
          movies

          expect(subject).to eq([movie_2])
        end
      end
    end
  end
end
