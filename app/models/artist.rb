class Artist < ActiveRecord::Base
  has_many :songs

  validates :name, presence: true # I added this, in order to test out my refactored code.
end
