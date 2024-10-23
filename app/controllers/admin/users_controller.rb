class Admin::UsersController < ApplicationController

  before_action :authenticate_admin!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @vegetables = @user.vegetables
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:notice] = "退会させました"
      redirect_to admin_users_path
    else
      flash[:alert] = "失敗しました"
      redirect_to request.referer
    end
  end


  private

  def authenticate_admin!
    unless admin_signed_in?
      flash[:alert] = "このページにアクセスできません"
      redirect_to root_path  #ユーザーのトップページへリダイレクト
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :introduction, :profile_image)
  end

end
