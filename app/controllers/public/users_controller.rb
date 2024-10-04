class Public::UsersController < ApplicationController
  def new
    @user = User.new
  end

  def mypage
    @user = current_user
    #@user = User.find(params[:id])

  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
      if @user.update(user_params)
        redirect_to admin_user_path(@user), notice: '会員情報が更新されました'
      else
        flash[:notice] = "更新に失敗しました"
        render :edit
      end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :is_active)
  end

  def set_user
    @user = user.find(params[:id])
  end

end