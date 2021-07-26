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

    def fetch_data
      data = Apis::Omdb::Movie.new(title: movie.title).call
      Apis::Omdb::Builders::Movie.new(data: data).build
    end

    def update_movie(response)
      movie.update!(response.except(:response))
    end
  end
end
