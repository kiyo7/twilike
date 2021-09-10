class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user &.authenticate(params[:session][:password]) #autheticateはtrueならuserオブジェクトを返す
      #↑user && user.メソッドの短縮系(&. "ぼっち演算子")
      if @user.activated?
        log_in @user #sessions_helperのメソッド
        params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
        redirect_back_or @user #userのプロフィールページへ
      else
        message = "アカウントは有効ではありません。"
        message += "登録したアドレスに送られたメールをご確認下さい。"
        flash[:waring] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = '存在しないユーザーまたはパスワードが違います' 
      render 'new' #renderとflashを使うときは注意が必要
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
