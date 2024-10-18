class Public::FavoritesController < ApplicationController

def create
  @vegetable = Vegetable.find(params[:vegetable_id])
  @favorite = current_user.favorites.new(vegetable_id: @vegetable.id)
  @favorite.save
  #redirect_back(fallback_location: admin_admin_top_path)
end

def destroy
  @vegetable = Vegetable.find(params[:vegetable_id])
  @favorite = current_user.favorites.find_by(vegetable_id: @vegetable.id)
  @favorite.destroy
  #redirect_back(fallback_location: admin_admin_top_path)
end


def vegetable_params
  params.require(:vegetable).permit(:name, :body, :image, :genre_id)
end

end
