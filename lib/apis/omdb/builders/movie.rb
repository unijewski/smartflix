# frozen_string_literal: true

module Apis
  module Omdb
    module Builders
      class Movie
        def initialize(data:)
          @data = data
        end

        def build
          return build_error_hash if data['Response'] == 'False'

          build_response_hash
        end

        private

        attr_reader :data

        def build_response_hash
          data.tap do |hash|
            alter_keys(hash)
            assign_proper_values(hash)
            hash.except!(:type)
          end
        end

        def alter_keys(hash)
          hash.transform_keys!(&:underscore)
          hash.symbolize_keys!
        end

        def assign_proper_values(hash)
          hash[:response] = cast_response_status(data[:response])
          hash[:movie_type] = data[:type]
          hash[:ratings] = data[:ratings].map { |h| h.values.join(': ') }.to_sentence
        end

        def build_error_hash
          {
            response: cast_response_status(data['Response']),
            error: data['Error']
          }
        end

        def cast_response_status(value)
          ActiveModel::Type::Boolean.new.cast(value.downcase)
        end
      end
    end
  end
end
