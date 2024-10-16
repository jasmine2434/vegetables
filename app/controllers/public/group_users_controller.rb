class Public::GroupUsersController < ApplicationController

  before_action :authenticate_user!

  def create
    @group_user = GroupUser.new(group_id: params[:group_id], user_id: current_user.id)
    if @group_user.save
      flash[:notice] = "ユーザーをグループに追加しました"
    else
      flash[:alert] = "ユーザーを追加できませんでした"
      redirect_to request.referer
    end
  end

  def destroy
    @group_user = GroupUser.find_by(group_id: params[:group_id], user_id: current_user.id)

    if @group_user
      @group_user.destroy
      flash[:notice] = "グループから退会しました。"
    else
      flash[:alert] = "グループから退会できませんでした。"
      redirect_to request.referer
    end
  end

end
