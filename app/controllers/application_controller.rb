class ApplicationController < ActionController::Base

#before_action :authenticate_user!

def after_sign_in_path_for(resource)
  case resource
  when Admin
    admin_path
  when User
    root_path
  else
    root_path
  end
end

def authenticate_admin!
  unless current_user&.admin?
    flash[:alert] = "このページにアクセスできません"
    redirect_to root_path  # アクセスできない場合はトップページへリダイレクト
  end
end



end
