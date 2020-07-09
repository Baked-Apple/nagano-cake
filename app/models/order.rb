class Order < ApplicationRecord
	belongs_to :member
	has_many :order_items, dependent: :destroy
	attr_accessor :registered_address, :delivery_info
	DELIVERY_INFO_DEFAULT = "self_addr"
	after_initialize do |obj|
		obj.delivery_info ||= DELIVERY_INFO_DEFAULT
	end
	enum pay_type: { credit: 0, bank: 1 }
	enum delivery_info: { self_addr: 0, registered_addr: 1, new_addr: 2 }
	enum order_status: { pending: 0, confirmed: 1, making: 2, preparing: 3, delivered: 4 }
end