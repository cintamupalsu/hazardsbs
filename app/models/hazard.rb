class Hazard < ApplicationRecord
    has_many :rectangles
    has_many :cells
end
