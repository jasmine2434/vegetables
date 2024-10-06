class Public::FavoritesController < ApplicationController
  
def create
  vegetable = Vegetable.find(params[:vegetable_id])
  favorite = current_user.favorites.new(vegetalbe_id: vegetalbe.id)
  favorite.save
  redirect_to vegetalbes_path(vegetalbe.id)
end

def destroy
    vegetalbe = Vegetalbe.find(params[:vegetalbe_id])
    favorite = current_user.favorites.find_by(vegetable_id: vegetable.id)
    favorite.destroy
    redirect_to vegetalbes_path(vegetalbe.id)
end
  
end
