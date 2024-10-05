class Public::UsersController < ApplicationController
  def new
    @user = User.new
  end

  def mypage
    @user = current_user
    @vegetables = current_user.vegetables
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = current_user
    if @user == current_user
      render :edit
    else
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
      if @user.update(user_params)
        flash[:notice] = "変更を保存しました"
        redirect_to my_page_path
      else
        flash[:notice] = "変更が失敗しました"
        render :edit
      end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :image)
  end

  def set_user
    @user = user.find(params[:id])
  end

end