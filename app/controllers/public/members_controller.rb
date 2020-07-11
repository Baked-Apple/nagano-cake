class Public::MembersController < ApplicationController
	before_action :authenticate_member!
	
	def show
		@member = current_member
	end

	def edit
		@member = current_member
	end

	def update
		@member = current_member
		if @member.update(member_params)
			redirect_to public_mypage_path(current_member), notice:'アカウント情報を更新しました'
		else
			render :edit
		end
  end

  def confirm
  end

	def hide
		@member = current_member
		# 退会ステータスをtrue＝退会済みにupdate
		@member.update(leave_status: true)
		# #ログアウトさせる
		reset_session
		#トップページにリダイレクト(後でルートパスに変更)
		redirect_to public_top_path
	end

    private
    def member_params
      params.require(:member).permit(:last_name, :first_name, :kana_last_name, :kana_first_name, :postal_code, :address, :phone_number, :email, :leave_status)
    end

end
