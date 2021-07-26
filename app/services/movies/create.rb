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

    def fetch_data
      data = Apis::Omdb::Movie.new(title: title).call
      Apis::Omdb::Builders::Movie.new(data: data).build
    end

    def log_warn
      Rails.logger.warn("#{Time.current}: #{title} movie not found!")
    end

    def create_movie(response)
      Movie.create!(response.except(:response))
    end
  end
end
