class Public::DeliveriesController < ApplicationController
	before_action :authenticate_member!
	
	def index
		@delivery = Delivery.new
		@deliveries = current_member.deliveries
	end

	def create
		@delivery = Delivery.new(delivery_params)
		@delivery.member_id = current_member.id
		if @delivery.save
			redirect_to public_deliveries_path
		else
			@deliveries = current_member.deliveries
			render :index
		end
	end

	def edit
		@delivery = Delivery.find(params[:id])
	end

	def update
		@delivery = Delivery.find(params[:id])
		if @delivery.update(delivery_params)
			redirect_to public_deliveries_path
		else
			render :edit
		end
	end

	def destroy
		delivery = Delivery.find(params[:id])
		delivery.destroy
		redirect_to public_deliveries_path
	end

	private

	def delivery_params
		params.require(:delivery).permit(:postal_code, :address, :name)
	end
end
