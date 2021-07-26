# frozen_string_literal: true

class DeleteOutdatedMoviesWorker
  include Sidekiq::Worker
  sidekiq_options queue: :movies, retry: false

  def perform
    Movie.outdated.destroy_all
  end
end
