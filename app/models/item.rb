class Item < ApplicationRecord
	has_many :order_items, dependent: :destroy
	belongs_to :genre
	has_many :cart_items, dependent: :destroy
	attachment :image

	validates :name, presence: true
	validates :introduction, presence: true
	validates :price, presence: true
	validates :sale_status, presence: true

	def price_with_tax
		(price * 1.1).floor
	end

end
