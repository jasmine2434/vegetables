class Admin::VegetablesController < ApplicationController

  def index
    @vegetables = Vegetable.all
  end

  def show
    @vegetable = Vegetable.find(params[:id])
    @user = @vegetable.user
  end

  def destroy
    @vegetable = Vegetable.find(params[:id])
    if @vegetable.destroy
      flash[:notice] = "削除されました"
      redirect_to my_page_path
    else
      flash[:notice] = "削除に失敗しました"
      render :edit
    end
  end


  private

  def vegetable_params
    params.require(:vegetable).permit(:name, :body, :image, :genre_id)
  end

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end



end
