# frozen_string_literal: true

class Movie < ApplicationRecord
  has_many :external_ratings, dependent: :destroy

  validates :title, presence: true

  scope :outdated, -> { where('updated_at < ?', 48.hours.ago) }

  def to_param
    title
  end
end
