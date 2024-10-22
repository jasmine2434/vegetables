class Public::FavoritesController < ApplicationController

  def create
    @vegetable = Vegetable.find(params[:vegetable_id])
    @favorite = current_user.favorites.new(vegetable_id: @vegetable.id)
    @favorite.save
  end

  def destroy
    @vegetable = Vegetable.find(params[:vegetable_id])
    @favorite = current_user.favorites.find_by(vegetable_id: @vegetable.id)
    @favorite.destroy
  end


  def vegetable_params
    params.require(:vegetable).permit(:name, :body, :image, :genre_id)
  end

end
