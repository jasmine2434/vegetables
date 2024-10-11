# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :user_state, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  def after_sign_in_path_for(resource)
    my_page_path
  end

  def after_sign_out_path_for(resource)
    about_path
  end

  private

  def user_state
      user = User.find_by(email: params[:name][:email])
      if user.nil?
        flash[:alert] = "アカウントが見つかりません。"
        redirect_to new_user_session_path and return
      end
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.guest_user?
      redirect_to user_path(current_user) , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません"
    end
  end

  def user_params
    params.require(:user).permit(:name, :email)
  end


end
