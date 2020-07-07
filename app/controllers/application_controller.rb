class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?

	private
	def after_sign_in_path_for(resource)
		# 管理者ログイン後　＝＞　トップページ
		if admin_signed_in?
			admin_top_path
		# 会員ログイン後　＝＞　トップページ
		elsif member_signed_in?
			public_mypage_path
		end
    end

    #sign out後トップページへ


    protected
	def configure_permitted_parameters
		#signup/ユーザー登録情報
		devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name, :kana_last_name, :kana_first_name, :postal_code, :address, :phone_number, :email, :leave_status])
		#login：name要
		devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
	end

end
