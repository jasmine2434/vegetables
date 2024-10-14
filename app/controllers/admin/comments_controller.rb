class Admin::CommentsController < ApplicationController

#before_action :authenticate_admin!, if: :admin_url

def index
  @vegetables = Vegetable.all
end



def destroy
  comment = Comment.find(params[:id])
  if comment.destroy
    flash[:notice] = "コメントを削除しました"
    redirect_to vegetable_path(comment.vegetable)
  else
    flash.now[:notice] = "コメント削除に失敗しました"
    render :show
  end
end


private

def admin_url
  request.fullpath.include?("/admin")
  flash[:alert] = "このページにアクセスできません"
  redirect_to root_path  # アクセスできない場合は、トップページへリダイレクト
end

def comment_params
  params.require(:comment).permit(:body, :id)
end

end
