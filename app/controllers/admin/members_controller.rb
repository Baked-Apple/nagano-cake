class Admin::MembersController < ApplicationController
	before_action :authenticate_admin!
	
	def index
	  @members = Member.page(params[:page])
		# 検索オブジェクト
    @search = Member.ransack(params[:q])
    # 検索結果
    @q_members = @search.result.page(params[:page])
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
			redirect_to admin_member_path(@member), notice:'アカウント情報を更新しました'
		else
			render 'edit'
		end
    end

	private
    def member_params
      params.require(:member).permit(:last_name, :first_name, :kana_last_name, :kana_first_name, :postal_code, :address, :phone_number, :email, :leave_status)
    end

end
