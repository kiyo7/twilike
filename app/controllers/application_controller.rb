class ApplicationController < ActionController::Base
  # Railsの全コントローラの親クラスであるApplicationコントローラにmoduleを読み込ませると全てのコントローラーで使えるようになる
  include SessionsHelper

  #################################################################

  private

  #################################################################

   # ログイン済みユーザーかどうか確認(before_action)
    def logged_in_user?
      unless logged_in? # ←ログインしていなかったら
        store_location #ログイン前にアクセスしたページを記憶
        flash[:danger] = "ログインが必要です！"
        redirect_to login_url
      end
    end
end
