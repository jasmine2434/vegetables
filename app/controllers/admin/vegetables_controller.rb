class Admin::VegetablesController < ApplicationController

  before_action :authenticate_admin!

  def index
    @vegetables = Vegetable.all
    @vegetable = Vegetable.new
  end

  def show
    @vegetable = Vegetable.find(params[:id])
    @user = @vegetable.user
  end

  def destroy
    @vegetable = Vegetable.find(params[:id])
    if @vegetable.destroy
      flash[:notice] = "削除されました"
      redirect_to admin_vegetables_path
    else
      flash.now[:notice] = "削除に失敗しました"
      render :show
    end
  end

  private

  def authenticate_admin!
    unless admin_signed_in?
      flash[:alert] = "このページにアクセスできません"
      redirect_to root_path  #ユーザーのトップページへリダイレクト
    end
  end

  def vegetable_params
    params.require(:vegetable).permit(:name, :body, :image, :genre_id)
  end

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end

end
