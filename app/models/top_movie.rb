class TopMovie < ApplicationRecord
  self.primary_key = :avg_rating

  def readonly?
    true
  end
end
