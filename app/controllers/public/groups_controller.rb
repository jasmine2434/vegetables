class Public::GroupsController < ApplicationController

  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]
  
  
  def new
    @user = User.find(current_user.id)
    @group = Group.new
  end
  
  def create
    @user = current_user
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    if @group.save
      flash[:notice] = "作成されました"
      redirect_to group_path(@group)
    else
       flash.now[:alert] = "作成に失敗しました"
      render :new
    end
  end
  
  def index
    @groups = Group.all
  end
  
  def show
    @group = Group.find(params[:id])
    @user = User.find(current_user.id)
  end
  
  def edit
    @group = Group.find(params[:id])
  end
  
  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      flash[:notice] = "更新されました"
      redirect_to group_path(@group)
    else
      flash.now[:alert] = "更新に失敗しました"
      render :edit
    end
  end
  
  def destroy
    @group = Group.find(params[:id])
    if @group.destroy
      flash[:notice] = "削除されました"
      redirect_to my_page_path
    else
      flash.now[:alert] = "削除に失敗しました"
      render :edit
    end
  end


  private
  
  def group_params
    params.require(:group).permit(:name, :introduction, :group_image)
  end
  
  def ensure_correct_user
    @group = Group.find(params[:id])
    unless @group.owner_id == current_user.id
      redirect_to vegetable_group_path
    end
  end


end
