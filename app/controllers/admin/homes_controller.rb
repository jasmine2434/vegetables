class Admin::HomesController < ApplicationController

  before_action :authenticate_admin!

  def top
  end

  private

  def authenticate_admin!
    unless admin_signed_in?
      flash[:alert] = "このページにアクセスできません"
      redirect_to root_path  #ユーザーのトップページへリダイレクト
    end
  end

end
