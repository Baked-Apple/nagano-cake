class Admin::MembersController < ApplicationController
	def index
		@members = Member.all
	end

	def show
		@member = Member.find(params[:id])
	end

	def edit
		@member = Member.find(params[:id])
	end

	def update
		@member = Member.find(params[:id])
		if @member.update(member_params)
			redirect_to admin_member_path(@member)
		else
			render 'edit'
		end
    end

	private
    def member_params
       params.require(:member).permit(:last_name, :first_name, :kana_last_name, :kana_first_name, :postal_code, :address, :phone_number, :email, :leave_status)
    end

    # def create_activation_digest
    # 	self.activation_token = Member.new_token
    # 	self.activation_digest = Member.digest(activation_token)
    # end


end
