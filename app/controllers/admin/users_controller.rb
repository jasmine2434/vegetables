class Admin::UsersController < ApplicationController

  #before_action :authenticate_admin!, if: :admin_url

  def index
    @users = User.all
    @vegetable = Vegetable.new
    @comments = Comment.all
    @favorites = Favorite.all
  end

  def show
    @user = User.find(params[:id])
    @vegetables = @user.vegetables
    @vegetable = Vegetable.new
    @comments = Comment.all
    @favorites = Favorite.all
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "退会させました"
  end


  private

  def admin_url
    request.fullpath.include?("/admin")
    flash[:alert] = "このページにアクセスできません"
    redirect_to root_path  # アクセスできない場合は、トップページへリダイレクト
  end

  def user_params
    params.require(:user).permit(:name, :profile_image, :image)
  end

end
