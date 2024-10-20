class Public::SearchesController < ApplicationController

  def search
    @model = params[:model]
    @content = params[:content]
    @method = params[:method]

    if @content.blank?
      flash[:alert] = "検索ワードを入力してくだい"
        redirect_to vegetables_path
    elsif @model  == "user"
        @records = User.search_for(@content, @method)
    elsif @model == "vegetable"
        @records = Vegetable.search_for(@content, @method)
    else
        @records = Group.search_for(@content, @method)
    end
  end

end