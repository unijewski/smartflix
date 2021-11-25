class CreateTopMovies < ActiveRecord::Migration[6.1]
  def change
    create_view :top_movies, materialized: true
  end
end
