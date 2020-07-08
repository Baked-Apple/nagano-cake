class CartItem < ApplicationRecord
	belongs_to :member
	belongs_to :item

	def subtotal_price
		(quantity * item.price * 1.08).round
	end
end
