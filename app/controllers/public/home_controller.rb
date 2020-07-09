class Public::HomeController < ApplicationController
  def top
  	 @genres = Genre.all

  	 @all_ranks = Item.find(OrderItem.group(:item_id).order('count(item_id) desc').limit(4).pluck(:item_id))
  end

  def about
  end
end
