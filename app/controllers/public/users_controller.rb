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
    @vegetables = @user.vegetables
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
    @user = current_user
      if @user.update(user_params)
        flash[:notice] = "変更を保存しました"
        redirect_to my_page_path
      else
        flash[:notice] = "変更が失敗しました"
        render :edit
      end
  end

  def destroy
    @user = current_user
    @user.destroy
    flash[:notice] = "退会しました"
    redirect_to new_user_registration_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :image)
  end

  def ensure_guest_user
    if current_user.email == "guest@example.com"
      redirect_to my_page_path(current_user) , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end

end