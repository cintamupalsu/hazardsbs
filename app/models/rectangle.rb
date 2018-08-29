class Rectangle < ApplicationRecord
  belongs_to :anchor
  belongs_to :hazard
  belongs_to :zone
end
