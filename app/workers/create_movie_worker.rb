class CreateMovieWorker
  include Sidekiq::Worker

  def perform
    Movie.create!(title: Faker::Movie.title)
  end
end
