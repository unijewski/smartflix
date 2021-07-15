# frozen_string_literal: true

module Movies
  class Create
    def initialize(title:)
      @title = title
    end

    def call
      movie = Movie.new(movie_attributes.except(:type))
      movie.movie_type = movie_attributes[:type]
      movie.ratings = alter_ratings(movie_attributes[:ratings])
      movie.save!
    end

    private

    attr_reader :title

    ATTRIBUTES_TO_SKIP = %i[response].freeze
    private_constant :ATTRIBUTES_TO_SKIP

    def movie_attributes
      @movie_attributes ||= fetch_data.parsed_response
                                      .transform_keys(&:underscore)
                                      .symbolize_keys
                                      .except(*ATTRIBUTES_TO_SKIP)
    end

    def fetch_data
      Apis::Omdb::Movie.new(title: title).call
    end

    def alter_ratings(ratings_hash)
      ratings_hash.map { |hash| hash.values.join(': ') }.to_sentence
    end
  end
end
