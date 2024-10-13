class Public::SearchesController < ApplicationController

  before_action :authenticate_user!

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
  end

end