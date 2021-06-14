class Movie < ApplicationRecord
  validates :title, presence: true

  def to_param
    title
  end
end
