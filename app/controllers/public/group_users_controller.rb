class Public::GroupUsersController < ApplicationController

  before_action :authenticate_user!


def create
  @group_user = GroupUser.new(user_id: current_user.id, group_id: params[:group_id])
  if @group_user.save
    redirect_to group_path(params[:group_id]), notice: 'グループに参加しました。'
  else
    redirect_to group_path(params[:group_id]), alert: 'グループへの参加に失敗しました。'
  end
end


def destroy
  @group_user = GroupUser.find_by(user_id: current_user.id, group_id: params[:group_id])
  if @group_user.destroy
    redirect_to group_path(params[:group_id]), notice: 'グループから退会しました。'
  else
    redirect_to group_path(params[:group_id]), alert: 'グループの退会に失敗しました。'
  end
end


end
