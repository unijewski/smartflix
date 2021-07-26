# frozen_string_literal: true

module Movies
  class Create
    def initialize(title:)
      @title = title
    end

    def call
      attributes = fetch_data
      return log_warn unless attributes[:response]

      create_movie(attributes)
    end

    private

    attr_reader :title

    def fetch_data
      data = Apis::Omdb::Movie.new(title: title).call
      Apis::Omdb::Builders::Movie.new(data: data).build
    end

    def log_warn
      Rails.logger.warn("#{Time.current}: #{title} movie not found!")
    end

    def create_movie(attributes)
      movie_attributes = attributes.except(:response)
      Movie.create!(movie_attributes)
    end
  end
end
