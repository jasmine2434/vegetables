class Admin::UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @vegetables = @user.vegetables
  end



  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :image)
  end



end
