class Public::GroupsController < ApplicationController

before_action :authenticate_user!
before_action :ensure_correct_user, only: [:edit, :update]


def new
  @group = Group.new
end

def create
  @user = current_user
  @group = Group.new(group_params)
  @group.owner_id = current_user.id
  if @group.save
    redirect_to vegetable_groups_path
  else
    @groups = Group.all
    @user = User.find(current_user.id)
    render :index
  end
end

def index
  @group = Group.new
  @groups = Group.all
  @user = User.find(current_user.id)
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
    flash[:notice] = "グループが作成されました"
    redirect_to user_groups_path
  else
    flash.now[:alert] = "グループの作成に失敗しました"
    render :edit
  end
end

def destroy
  @group = Group.find(params[:id])
  if @group.destroy
    flash[:notice] = "削除されました"
    redirect_to user_groups_path
  else
    flash.now[:notice] = "削除に失敗しました"
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
