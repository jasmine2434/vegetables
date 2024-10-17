class Admin::SearchesController < ApplicationController

  #before_action :authenticate_admin!

  def search
    @model = params[:model]
    @content = params[:content]
    @method = params[:method]

    if @content.blank?
      flash[:notice] = "検索ワードを入力してくだい"
        redirect_to vegetables_path
    elsif @model  == "user"
        @records = User.search_for(@content, @method)
    else
        @records = Vegetable.search_for(@content, @method)
    end
    render 'public/searches/search'
  end


  private

  def authenticate_admin!
    unless current_user&.admin?
      flash[:alert] = "このページにアクセスできません"
      redirect_to root_path  # アクセスできない場合は、トップページへリダイレクト
    end
  end

end
