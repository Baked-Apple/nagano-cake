class Order < ApplicationRecord
	belongs_to :member
	has_many :order_items, dependent: :destroy
	attr_accessor :registered_address, :delivery_info
	DELIVERY_INFO_DEFAULT = "self_addr"
	after_initialize do |obj|
		obj.delivery_info ||= DELIVERY_INFO_DEFAULT
	end
	enum pay_type: { credit: 1, bank: 2 }
	enum delivery_info: { self_addr: 1, registered_addr: 2, new_addr: 3 }
end
