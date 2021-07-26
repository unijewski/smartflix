# frozen_string_literal: true

module Movies
  class Update
    def initialize(movie:)
      @movie = movie
    end

    def call
      attributes = fetch_data
      return false unless attributes[:response]

      update_movie(attributes)
    end

    private

    attr_reader :movie

    def fetch_data
      data = Apis::Omdb::Movie.new(title: movie.title).call
      Apis::Omdb::Builders::Movie.new(data: data).build
    end

    def update_movie(attributes)
      movie_attributes = attributes.except(:response)
      movie.update!(movie_attributes)
    end
  end
end
