# frozen_string_literal: true

class UpdateAllMoviesWorker
  include Sidekiq::Worker
  sidekiq_options queue: :movies, retry: false

  def perform
    Movie.find_each do |movie|
      UpdateMovieWorker.perform_async(movie.id)
    end
  end
end
