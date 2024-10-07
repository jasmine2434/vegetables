class Public::FavoritesController < ApplicationController

def create
  vegetable = Vegetable.find(params[:vegetable_id])
  favorite = current_user.favorites.new(vegetable_id: vegetable.id)
  favorite.save
  redirect_to my_page_path(vegetable.id)
end

def destroy
    vegetable = Vegetable.find(params[:vegetable_id])
    favorite = current_user.favorites.find_by(vegetable_id: vegetable.id)
    favorite.destroy
    redirect_to my_page_path(vegetable.id)
end

end
