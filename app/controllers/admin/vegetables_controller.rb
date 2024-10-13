class Admin::VegetablesController < ApplicationController

  #before_action :authenticate_admin!, if: :admin_url

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
      redirect_to my_page_path
    else
      flash.now[:notice] = "削除に失敗しました"
      render :edit
    end
  end

  private

  def admin_url
    request.fullpath.include?("/admin")
    flash[:alert] = "このページにアクセスできません"
    redirect_to root_path  # アクセスできない場合は、トップページへリダイレクト
  end

  def vegetable_params
    params.require(:vegetable).permit(:name, :body, :image, :genre_id)
  end

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end

end
