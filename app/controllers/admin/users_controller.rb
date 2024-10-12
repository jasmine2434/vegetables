class Admin::UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @vegetables = @user.vegetables
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "退会させました"
  end


  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :image)
  end



end
