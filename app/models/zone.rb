class Zone < ApplicationRecord
    has_many :ways
    has_many :nodes
    has_many :rectangles
end
