class Admin::SearchesController < ApplicationController

  before_action :authenticate_admin!

  def search
    @model = params[:model]
    @content = params[:content]
    @method = params[:method]

    if @content.blank?
      flash[:notice] = "検索ワードを入力してくだい"
      redirect_to request.referer and return
    elsif @model  == "user"
      @records = User.search_for(@content, @method)
    elsif @model == "vegetable"
      @records = Vegetable.search_for(@content, @method)
    elsif @model == "group"
      @records = Group.search_for(@content, @method)
    else
      @records = Comment.search_for(@content, @method)
    end
  end


  private

  def authenticate_admin!
    unless admin_signed_in?
      flash[:alert] = "このページにアクセスできません"
      redirect_to root_path  # アクセスできない場合は、トップページへリダイレクト
    end
  end

end
