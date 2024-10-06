class Public::VegetablesController < ApplicationController

  def new
    @vegetable = Vegetable.new
    @user = current_user
  end

  def create
    @vegetable = Vegetable.new(post_params)
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
    @vegetables = Vegetable.find(params[:id])
  end

  def edit
    @vegetables = Vegetable.find(params[:id])
  end

  def update
    @vegetable= Vegetable.find(params[:id])
    if @vegetalbe.update(post_params)
      flash[:notice] = "更新されました"
      redirect_to public_users_mypage_path
    else
      flash[:notice] = "更新に失敗しました"
      render :edit
    end
  end

  def destroy
    @vegetable = Vegetable.find(params[:id])
    @vegetalbe.destroy
    redirect_to vegetable_path
  end

  private

  def post_params
    params.require(:vegetable).permit(:vege_name, :body, :image)
  end

  def check_user
    @vegetable = Vegetable.find(params[:id])
    unless @vegetalbe.user == current_user
      redirect_to vegetables_path
    end
  end

end
