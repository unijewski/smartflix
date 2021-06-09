module Apis
  module Omdb
    class Movie < Base
      def initialize(title:)
        super()
        @title = title
      end

      def call
        self.class.get('', query: { t: title })
      end

      private

      attr_reader :title
    end
  end
end
