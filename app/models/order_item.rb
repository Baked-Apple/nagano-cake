class OrderItem < ApplicationRecord
	belongs_to :order
	belongs_to :item
	enum product_status: { ng: 0, waiting: 1, making: 2, done: 3 }
end
