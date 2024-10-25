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
    @user = current_user
    if params[:post]
      @vegetable.is_draft = false
      if @vegetable.save
        flash[:notice] = "投稿されました"
        redirect_to vegetable_path(@vegetable)
      else
        flash.now[:alert] = "投稿に失敗しました"
        render :new
      end
    else
      if @vegetable.update(is_draft: true)
        flash[:notice] = "下書き保存されました"
        redirect_to vegetable_path(@vegetable)
      else
        flash.now[:alert] = "下書き保存に失敗しました"
        render :new
      end
    end
  end

  def index
    @vegetables = Vegetable.where(is_draft: false)
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

    if params[:publicize_draft]
      @vegetable.attributes = vegetable_params.merge(is_draft: false)
      if @vegetable.save(context: :publicaze)
         flash[:notice] = "投稿しました"
        redirect_to vegetable_path(@vegetable.id)
      else
        @vegetable.is_draft = true
        flash.now[:alert] = "投稿に失敗しました"
        render :edit
      end
    elsif params[:update_vegetable]
        @vegetable.attributes = vegetable_params
        if @vegetable.save
          flash[:notice] = "更新されました"
          redirect_to vegetable_path(@vegetable.id)
        else
          flash.now[:alert] = "更新に失敗しました"
          render :edit
        end
    else
      if @vegetable.update(vegetable_params)
        flash[:notice] = "上書き保存しました"
        redirect_to vegetable_path(@vegetable.id)
      else
        flash.now[:alert] = "上書きに失敗しました"
        render :edit
      end
    end
  end

  def destroy
    @vegetable = Vegetable.find(params[:id])
    if @vegetable.destroy
      flash[:notice] = "削除されました"
      redirect_to my_page_path
    else
      flash.now[:alert] = "削除に失敗しました"
      render :edit
    end
  end

  private

  def vegetable_params
    params.require(:vegetable).permit(:name, :body, :image, :genre_id, :is_draft)
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
