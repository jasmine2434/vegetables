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









  # def create
  #   group_user = current_user.group_users.new(user_id: current_user.id, group_id: params[:group_id])
  #   if group_user.save
  #     flash[:notice] = "グループに参加しました"
  #   else
  #     flash[:alert] = "グループに参加できませんでした"
  #     redirect_to request.referer
  #   end
  # end

  # def destroy
  #   group_user = current_user.group_users.find_by(user_id: current_user.id, group_id: params[:group_id])
  #   if group_user.destroy
  #     flash[:notice] = "グループから退会しました。"
  #   else
  #     flash[:alert] = "グループから退会できませんでした。"
  #     redirect_to request.referer
  #   end
  # end

end
