class Public::VegetablesController < ApplicationController

  def new
    @vegetable = Vegetable.new
    @user = current_user
    @genres = Genre.all
  end

  def create
    @vegetable = Vegetable.new(vegetable_params)
    @vegetable.user_id = current_user.id
    if @vegetable.save
        flash[:notice] = "投稿されました"
        redirect_to my_page_path(@vegetable.id)
    else
        @user = current_user
        flash[:notice] = "投稿に失敗しました"
        render :new
    end
  end

  def index
    @users = User.all
    @vegetables = Vegetable.all
    @user = current_user
  end

  def show
    @user = current_user
    @vegetable = Vegetable.find(params[:id])
  end

  def edit
    @vegetable = Vegetable.find(params[:id])
    @genres = Genre.all
  end

  def update
    @genres = Genre.all
    @vegetable= Vegetable.find(params[:id])
    if @vegetable.update(vegetable_params)
      flash[:notice] = "更新されました"
      redirect_to vegetable_path(@vegetable)
    else
      flash[:notice] = "更新に失敗しました"
      render :edit
    end
  end

  def destroy
    @vegetable = Vegetable.find(params[:id])
    @vegetable.destroy
    redirect_to vegetable_path
  end

  private

  def vegetable_params
    params.require(:vegetable).permit(:vege_name, :body, :image, :genre_id)
  end

  def check_user
    @vegetable = Vegetable.find(params[:id])
    unless @vegetalbe.user == current_user
      redirect_to vegetables_path
    end
  end

end
