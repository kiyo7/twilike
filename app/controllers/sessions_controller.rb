class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
    else
       flash.now[:danger] = '存在しないユーザーまたはパスワードが違います' 
    render 'new' #renderとflashを使うときは注意が必要
    end
  end

  def destroy
  end

end
