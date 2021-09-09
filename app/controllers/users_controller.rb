class UsersController < ApplicationController


  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user #新規登録後流れでログインさせる
      flash[:success] = 'ようこそTwiLikeへ!'
      redirect_to @user #redirect_to user_url(@user)と同じ
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = 'プロフィールが更新されました！'
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

  #フォームに入力された値をparamsで直接渡してはいけないのでStrongParameterを使う
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
