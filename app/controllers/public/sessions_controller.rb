# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

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


  private

  def customer_state
      customer = User.find_by(email: params[:user][:email])
      if customer.nil?
        flash[:alert] = "アカウントが見つかりません。新規会員登録を行ってください。"
        redirect_to new_user_registration_path and return
      end

      if user.is_active == false
        flash[:alert] = "退会済みです。新規会員登録を行ってください"
        redirect_to new_user_registration_path
      end
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.guest_user?
      redirect_to user_path(current_user) , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end  

end
