class Track < ApplicationRecord
  belongs_to :trackable, polymorphic: true
end
