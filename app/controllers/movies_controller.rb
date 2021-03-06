# frozen_string_literal: true

class MoviesController < ApplicationController
  def index
    @movies = Movie.page(params[:page]).per(5)
  end

  def show
    movie = Movie.find_by(title: params[:title])
    if movie
      render json: movie
    else
      CreateMovieWorker.perform_async(params[:title])
      render json: { error: 'Not found' }, status: :not_found
    end
  end

  def top
    @top_movies = TopMovie.all
  end
end
