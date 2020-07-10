class Admin::HomeController < ApplicationController
  before_action :authenticate_admin!

  def top
    @count = Order.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).count
  end

end
