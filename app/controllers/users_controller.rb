class UsersController < ApplicationController

  before_action :logged_in_user?, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  #User.paginate(page: 1)で30件のユーザーがヒットします.
  def index
    @users = User.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.account_activation(@user).deliver_now
      flash[:info] = "登録されたアドレスに認証メールを送信しました。ご確認下さい。"
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = 'プロフィールが更新されました！'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = 'ユーザーを削除しました'
    redirect_to users_url
  end

  private

  #フォームに入力された値をparamsで直接渡してはいけないのでStrongParameterを使う
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end 
    # ログイン済みユーザーかどうか確認(before_action)
    def logged_in_user?
      unless logged_in? # ←ログインしていなかったら
        store_location #ログイン前にアクセスしたページを記憶
        flash[:danger] = "ログインが必要です！"
        redirect_to login_url
      end
    end

    # 正しいユーザーかどうかを確認
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user) #ヘルパーのcurrent_user?メソッド
    end

    #管理者かどうか確認
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
