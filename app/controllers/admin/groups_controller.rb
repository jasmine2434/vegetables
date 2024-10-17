class Admin::GroupsController < ApplicationController

before_action :authenticate_admin!

def index
  @groups = Group.all
end

def show
  @group = Group.find(params[:id])
end

def destroy
  group = Group.find(params[:id])
  if group.destroy
    flash[:notice] = "コメントを削除しました"
    redirect_to admin_groups_path
  else
    flash.now[:notice] = "コメント削除に失敗しました"
    render :index
  end
end


private

def authenticate_admin!
  unless admin_signed_in?
    flash[:alert] = "このページにアクセスできません"
    redirect_to root_path  #ユーザーのトップページへリダイレクト
  end
end

def group_params
  params.require(:group).permit(:name, :introduction)
end


end
