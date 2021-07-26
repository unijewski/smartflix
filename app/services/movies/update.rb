# frozen_string_literal: true

module Movies
  class Update
    def initialize(movie:)
      @movie = movie
    end

    def call
      response_body = fetch_data
      return false unless response_body[:response]

      update_movie(response_body)
    end

    private

    attr_reader :movie

    ATTRIBUTES_TO_SKIP = %i[response type].freeze
    private_constant :ATTRIBUTES_TO_SKIP

    def fetch_data
      data = Apis::Omdb::Movie.new(title: movie.title).call
      build_response_hash(data)
    end

    def build_response_hash(data)
      data.parsed_response.tap do |hash|
        hash.transform_keys!(&:underscore)
        hash.symbolize_keys!
        hash[:response] = ActiveModel::Type::Boolean.new.cast(data[:response].downcase)
      end
    end

    def update_movie(response)
      movie.assign_attributes(response.except(*ATTRIBUTES_TO_SKIP))
      assign_movie_type(movie, response[:type])
      alter_ratings(movie, response[:ratings])
      movie.save!
    end

    def assign_movie_type(movie, type)
      movie.movie_type = type
    end

    def alter_ratings(movie, ratings_hash)
      movie.ratings = ratings_hash.map { |hash| hash.values.join(': ') }.to_sentence
    end
  end
end
