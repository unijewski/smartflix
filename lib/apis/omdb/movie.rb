# frozen_string_literal: true

module Apis
  module Omdb
    class Movie < Base
      def initialize(title:)
        super()
        @title = title
      end

      def call
        self.class.get('', query: { t: title }).parsed_response
      end

      private

      attr_reader :title
    end
  end
end
