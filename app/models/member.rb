class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :orders, dependent: :destroy
  has_many :deliveries, dependent: :destroy
  has_many :cart_items, dependent: :destroy

  #退会ステータス０＝有効のみログイン可
  def active_for_authentication?
    super && (self.leave_status == 0)
  end

end
