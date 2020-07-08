class Item < ApplicationRecord
	has_many :order_items, dependent: :destroy
	belongs_to :genre
	has_many :cart_items, dependent: :destroy
	attachment :image

	def price_with_tax
    (price * 1.08).round
  end

end
