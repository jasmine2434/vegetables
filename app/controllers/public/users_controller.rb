class Public::UsersController < ApplicationController

  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit]

  def new
    @user = User.new
  end

  def mypage
    @user = current_user
    @vegetables = @user.vegetables
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = current_user
    if @user == current_user
      render :edit
    else
      redirect_to my_page_path(current_user)
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
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to vegetable_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :image)
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.guest_user?
      redirect_to user_path(current_user) , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end

end