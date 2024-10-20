class Admin::CommentsController < ApplicationController

before_action :authenticate_admin!

def index
  @comments = Comment.all
end

def show
  @vegetable = Vegetable.find(params[:id])
  @user = @vegetable.user
end

def destroy
  @comment = Comment.find(params[:id])
  if @comment.destroy
    flash[:notice] = "コメントを削除しました"
    redirect_to admin_comments_path
  else
    flash.now[:notice] = "コメント削除に失敗しました"
    render :index
  end
end


private

def authenticate_admin!
  unless admin_signed_in?
    flash[:alert] = "このページにアクセスできません"
    redirect_to root_path  #ユーザーのトップページへリダイレクト
  end
end

def comment_params
  params.require(:comment).permit(:body)
end

def vegetable_params
  params.require(:vegetable).permit(:name, :body, :image, :genre_id)
end

end
