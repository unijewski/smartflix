# frozen_string_literal: true

class UpdateMovieWorker
  include Sidekiq::Worker
  sidekiq_options queue: :movies, retry: false

  def perform(movie_id)
    movie = Movie.find(movie_id)
    Movies::Update.new(movie: movie).call
  end
end
