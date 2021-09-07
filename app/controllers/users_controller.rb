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
      flash[:success] = 'ようこそTwiLikeへ!'
      redirect_to @user #redirect_to user_url(@user)と同じ
    else
      render 'new'
    end
  end

  private

  #フォームに入力された値をparamsで直接渡してはいけないのでStrongParameterを使う
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

end
