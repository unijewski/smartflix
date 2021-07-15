# frozen_string_literal: true

module Movies
  class Create
    def initialize(title:)
      @title = title
    end

    def call
      response_body = fetch_data
      return log_warn unless response_body[:response]

      create_movie(response_body)
    end

    private

    attr_reader :title

    ATTRIBUTES_TO_SKIP = %i[response type].freeze
    private_constant :ATTRIBUTES_TO_SKIP

    def fetch_data
      data = Apis::Omdb::Movie.new(title: title).call
      build_response_hash(data)
    end

    def build_response_hash(data)
      data.parsed_response.tap do |hash|
        hash.transform_keys!(&:underscore)
        hash.symbolize_keys!
        hash[:response] = ActiveModel::Type::Boolean.new.cast(data[:response].downcase)
      end
    end

    def log_warn
      Rails.logger.warn("#{title} movie not found!")
    end

    def create_movie(response)
      Movie.new(response.except(*ATTRIBUTES_TO_SKIP)).tap do |movie|
        assign_movie_type(movie, response[:type])
        alter_ratings(movie, response[:ratings])
        movie.save!
      end
    end

    def assign_movie_type(movie, type)
      movie.movie_type = type
    end

    def alter_ratings(movie, ratings_hash)
      movie.ratings = ratings_hash.map { |hash| hash.values.join(': ') }.to_sentence
    end
  end
end
