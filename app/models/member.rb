class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :orders, dependent: :destroy
  has_many :deliveries, dependent: :destroy
  has_many :cart_items, dependent: :destroy

  #退会ステータス active(会員)　resign(退会)
  enum leave_status: {有効: false, 退会済み: true}

  #ユーザーが有効であることを確認
  def active_for_authentication?
  	super && (self.leave_status == false)
  end

  #退会したユーザーにカスタムメッセージを追加
  def inactive_message
  	(self.leave_status == false) ? super : :deleted_account
  end

end
