class Public::UsersController < ApplicationController

  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit]
  before_action :correct_user, only: [:edit, :update]

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
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:notice] = "変更を保存しました"
      redirect_to my_page_path
    else
      flash.now[:alert] = "変更が失敗しました"
      render :edit
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :image)
  end

  def ensure_guest_user
    if current_user.email == "guest@example.com"
      redirect_to my_page_path(current_user) , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません"
    end
  end

  def correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      flash[:alert] = "他のユーザーの編集はできません"
      redirect_to my_page_path(current_user) # マイページにリダイレクト
    end
  end

end