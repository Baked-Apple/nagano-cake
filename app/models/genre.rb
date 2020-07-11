class Genre < ApplicationRecord
	has_many :items

	validates :genre, presence: true
	validates :invalid_status, presence: true
end
