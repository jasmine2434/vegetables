class Admin::GenresController < ApplicationController

  before_action :authenticate_admin!

  def index
    @genres = Genre.all
    @genre = Genre.new
  end

  def new
    @genre = Genre.new
  end

  def create
    @genres = Genre.all
    @genre = Genre.new(genre_params)
    if @genre.save
      flash[:notice] = "ジャンルが作成されました"
      redirect_to admin_genres_path
    else
      flash.now[:alert] = "ジャンルの作成に失敗しました"
      render :index
    end
  end

  def edit
    @genres = Genre.all
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      flash[:notice] = "ジャンルが更新されました"
      redirect_to admin_genres_path
    else
      flash.now[:alert] = "ジャンルの更新に失敗しました"
      render :edit
    end
  end

  def destroy
    @genre = Genre.find(params[:id])
    if @genre.destroy
      flash[:notice] = "ジャンルが削除されました"
      redirect_to admin_genres_path
    else
      flash.now[:alert] = "ジャンルの削除に失敗しました"
      render :edit
    end
  end


  private

  def authenticate_admin!
    unless admin_signed_in?
      flash[:alert] = "このページにアクセスできません"
      redirect_to root_path  #ユーザーのトップページへリダイレクト
    end
  end

  def genre_params
    params.require(:genre).permit(:name)
  end
end
