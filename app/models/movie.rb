# frozen_string_literal: true

class Movie < ApplicationRecord
  validates :title, presence: true

  scope :outdated, -> { where('updated_at < ?', 48.hours.ago) }

  def to_param
    title
  end
end
