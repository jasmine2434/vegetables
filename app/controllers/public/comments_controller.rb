class Public::CommentsController < ApplicationController

def create
  #@vegetable = Vegetable.find(params[:vegetable_id])
  @comment = current_user.comments.new(comment_params)
  @comment.vegetable_id = @vegetable.id
  if @comment.save
    flash[:notice] = "コメントが作成されました"
    redirect_to vegetable_path(@vegetable)
  else
    flash.now[:alert] = "コメント送信に失敗しました"
    render :show
  end
end


def destroy
  comment = Comment.find(params[:id])
  if comment.destroy
    flash[:notice] = "コメントを削除しました"
    redirect_to vegetable_path(comment.vegetable)
  else
    flash.now[:alert] = "コメント削除に失敗しました"
    render :show
  end
end

private

def comment_params
  params.require(:comment).permit(:body, :id)
end

end
