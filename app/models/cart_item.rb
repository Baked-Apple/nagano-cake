class CartItem < ApplicationRecord
	belongs_to :member
	belongs_to :item

	validates :quantity, presence: true

	def subtotal_price
		(quantity * item.price * 1.1).floor
	end
end
