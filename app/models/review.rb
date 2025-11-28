class Review < ApplicationRecord
  belongs_to :list

  validates :comment, presence: true
  validates :rating, numericality: { only_integer: true, range: (1..5) }
end
