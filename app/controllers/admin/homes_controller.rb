class Admin::HomesController < ApplicationController

  #before_action :authenticate_admin!

  def top
  end

  private

  def authenticate_admin!
    unless current_user&.admin?
      flash[:alert] = "このページにアクセスできません"
      redirect_to root_path  # アクセスできない場合は、トップページへリダイレクト
    end
  end

end
