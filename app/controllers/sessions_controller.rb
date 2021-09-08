class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user &.authenticate(params[:session][:password]) 
      #↑user && user.メソッドの短縮系(&. "ぼっち演算子")
      log_in user #sessions_helperのメソッド
      redirect_to user #userのプロフィールページへ
    else
       flash.now[:danger] = '存在しないユーザーまたはパスワードが違います' 
    render 'new' #renderとflashを使うときは注意が必要
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

end
