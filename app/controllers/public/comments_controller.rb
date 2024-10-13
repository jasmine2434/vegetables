class Public::CommentsController < ApplicationController

def create
  vegetable = Vegetable.find(params[:vegetable_id])
  @comment = current_user.comments.new(comment_params)
  @comment.vegetable_id = vegetable.id
  @comment.save
  flash[:notice] = "コメントが作成されました"
end


def destroy
  comment = BookComment.find(params[:id])
  comment.destroy
end

private

  def comment_params
    params.require(:comment).permit(:body)
  end

end
