class Delivery < ApplicationRecord
	belongs_to :member
	validates :postal_code, presence: true, length: { minimum: 7,maximum: 7 }
	validates :address, presence: true
	validates :name, presence: true
end
