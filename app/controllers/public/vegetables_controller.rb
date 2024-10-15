class Public::VegetablesController < ApplicationController
before_action :authenticate_user!
before_action :correct_user, only: [:edit, :update]

  def new
    @vegetable = Vegetable.new
    @user = current_user
    @genres = Genre.all
  end

  def create
    @vegetable = Vegetable.new(vegetable_params)
    @genres = Genre.all
    @vegetable.user_id = current_user.id
    if @vegetable.save
      flash[:notice] = "投稿されました"
      redirect_to vegetable_path(@vegetable)
    else
      @user = current_user
      flash.now[:alert] = "投稿に失敗しました"
      render :new
    end
  end

  def index
    @vegetables = Vegetable.all
    @vegetable = Vegetable.new
  end

  def show
    @vegetable = Vegetable.find(params[:id])
    @user = @vegetable.user
    @comment = Comment.new
  end

  def edit
    @genres = Genre.all
    @vegetable = Vegetable.find(params[:id])
  end

  def update
    @genres = Genre.all
    @vegetable= Vegetable.find(params[:id])
    if @vegetable.update(vegetable_params)
      flash[:notice] = "更新されました"
      redirect_to vegetable_path
    else
      flash.now[:alert] = "更新に失敗しました"
      render :edit
    end
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

  def vegetable_params
    params.require(:vegetable).permit(:name, :body, :image, :genre_id)
  end

  def user_params
    params.require(:user).permit(:name, :profile_image, :image)
  end

  def correct_user
    @vegetable = Vegetable.find(params[:id])
    unless @vegetable.user == current_user
      flash[:alert] = "他のユーザーの投稿を編集することはできません"
      redirect_to vegetables_path # 投稿一覧画面にリダイレクト
    end
  end

end
