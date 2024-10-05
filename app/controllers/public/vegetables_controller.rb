class Public::VegetablesController < ApplicationController
    
  def new
    @vegetable = Vegetable.new
    @user = current_user
  end
    
  def create
    @vegetable = Vegetalbe.new(vegetalbe_params)
    @vegetable.user_id = current_user.id
    if @vegetable.save
        flash[:notice] = "投稿されました"
        redirect_to post_path(@post.id)
    else
        @users = User.all
        @vegetables = Post.all
        @user = current_user
        render :index
    end
  end
  
  def index
    @users = User.all
    @vegetable = Post.new
    @user = current_user
    @posts = Post.all
  end

  def mypage
    @posts = Post.all
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "更新されました"
      redirect_to public_users_mypage_path
    else
      render :edit
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:vege_name, :body, :image)
  end

  def check_user
    @post = Post.find(params[:id])
    unless @post.user == current_user
      redirect_to posts_path
    end
  end  
  
end
